package ua.bp;

import java.time.LocalDateTime;
import java.util.Arrays;

import org.bson.Document;

import com.mongodb.MongoException;
import com.mongodb.MongoQueryException;
import com.mongodb.client.AggregateIterable;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.UpdateOptions;

public class OrderManager{
    private MongoCollection<Document> col;
    private final long TTL;
    private final int MAX_AMOUNT;

    public OrderManager(String url, int port, String database, String collection,long TTL, int MAX_AMOUNT) throws MongoException{
        this.col=MongoClients
        .create("mongodb://"+url+":"+port)
        .getDatabase(database)
        .getCollection(collection);

        this.TTL=TTL;
        this.MAX_AMOUNT=MAX_AMOUNT;
    }

    public OrderManager(long TTL, int MAX_AMOUNT) throws MongoException{
        this("localhost",27017,"cbd","orders",TTL,MAX_AMOUNT);
    }

    public boolean insertOrderLimitProduct(String username, Order order) throws MongoException{
        if(overLimit(username)){
            return false;
        }else{
            return upsertProduct(username, order);
        }
    }

    public boolean insertOrderLimitQuantity(String username, Order order) throws MongoException{
        if(overLimit(username,order.amount())){
            return false;
        }else{
            return upsertProduct(username,order);
        }
    }

    public boolean overLimit(String username) throws MongoException{
        LocalDateTime startDateTime=LocalDateTime.now().minusSeconds(TTL);
            
        MongoCursor<Document> cursor=col.aggregate(Arrays.asList(
            new Document("$match",new Document("username",username)),
            new Document("$unwind","$orders"),
            new Document("$match",new Document("timestamp",new Document("$gte",startDateTime))),
            new Document("$count","timeSlotOrders")
        )).iterator();

        if(!cursor.hasNext()){
            return false;
        }else{
            
        }
    }

    public boolean overLimit(String username, int amount) throws MongoException{
        LocalDateTime startDateTime=LocalDateTime.now().minusSeconds(TTL);
        
        int present_amount=(int)col.aggregate(Arrays.asList(
            new Document("$match",new Document("username",username)),
            new Document("$unwind","$orders"),
            new Document("$match",new Document("orders.timestamp",new Document("$gte",startDateTime))),
            new Document("$group",
                new Document("_id","")
                .append("totalAmount",new Document("$sum","$orders.amount"))
            )
        )).first().get("totalAmount");

        if(present_amount+amount>MAX_AMOUNT){
            return true;
        }else{
            return false;
        }
    }

    protected boolean upsertProduct(String username, Order order) throws MongoException{
        col.updateOne(
            new Document("username",username),
            new Document("$push", new Document("orders",
                new Document("product_name",order.product_name())
                .append("amount",order.amount())
                .append("timestamp",LocalDateTime.now())
            )),
            new UpdateOptions().upsert(true)
        );
        return true;
    }
}
