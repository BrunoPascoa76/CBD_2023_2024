package ua.bp;

import java.util.Arrays;

import org.bson.Document;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;

public class Ex3a 
{
    public static void main( String[] args )
    {
        MongoDatabase db = MongoClients.create("mongodb://localhost:27017").getDatabase("cbd");
        MongoCollection<Document> test_collection=db.getCollection("l2_3a");
        test_collection.insertMany(Arrays.asList(
            new Document("string","abc").append("number",12).append("array",Arrays.asList(1,2,3,4)),
            new Document("string","def").append("number",15).append("array",Arrays.asList(5,6,7,8))
        ));

        MongoCursor<Document> cursor=test_collection.find().iterator();

        System.out.println("Check Insert:");
        try{
            while(cursor.hasNext()){
                System.out.println(cursor.next().toJson());
            }
        }finally{
            cursor.close();
        }


        test_collection.updateOne(
            new Document("number",new Document("$gt",13)),
            new Document("$set",new Document("string","ghi"))
        );
        
        cursor=test_collection.find(new Document("string","ghi")).projection(
                new Document("_id",false)
                    .append("string",true)
                    .append("number",true)
            ).iterator();

        System.out.println("Check update+find:");
        try{
            while(cursor.hasNext()){
                System.out.println(cursor.next().toJson());
            }
        }finally{
            cursor.close();
        }

        test_collection.deleteMany(new Document());
        System.exit(0);
    }
}
