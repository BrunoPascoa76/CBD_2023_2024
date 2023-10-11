package ua.bp;

import java.util.Arrays;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.mongodb.MongoException;

public class Ex4b {
    public static void main( String[] args ) throws InterruptedException
    {
        System.setProperty("logFilename","CBD_L204b-out_107418");
        Logger log=LogManager.getLogger();
        final int MAX_AMOUNT=6;
        final long TTL=10;
        final String user1="José";
        final String user2="Maria";
        final String insertionMessage="%s) Inserting product %s (X%d)...";

        OrderManager manager;
        List<Order> orders=Arrays.asList(
            new Order("Comida para cão",2),
            new Order("Comidade para gato",4),
            new Order("Comida para peixe",1)
        );
        log.info("Variables:\n\tMAX_AMOUNT="+MAX_AMOUNT+"\n\tTTL="+TTL+"\n\tuser1="+user1+"\n\tuser2="+user2);

        try{
            log.info("Creating manager...");
            manager=new OrderManager(TTL,MAX_AMOUNT);
        
            log.info("Testing insertions (last one should fail):");
            for(Order order: orders){
                log.info(String.format(insertionMessage,user1,order.product_name(),order.amount()));
                if(manager.insertOrderLimitAmount(user1, order)){
                    log.info("Insertion successful");
                }else{
                    log.warn("Insertion failed");
                }
            }

            log.info("Testing insertion with other user (should succeed):");
            log.info(String.format(insertionMessage,user2,orders.get(0).product_name(),orders.get(0).amount()));
            if(manager.insertOrderLimitAmount(user2, orders.get(0))){
                log.info("Insertion successful");
            }else{
                log.warn("Insertion failed");
            }

            log.info("Testing after waiting for TTL to expire (should succeed):");
            Thread.sleep(TTL*1000);
            log.info(String.format(insertionMessage,user1,orders.get(orders.size()-1).product_name(),orders.get(orders.size()-1).amount()));
            if(manager.insertOrderLimitAmount(user1, orders.get(orders.size()-1))){
                log.info("Insertion successful");
            }else{
                log.warn("Insertion failed");
            }
            manager.reset();

        }catch(MongoException e){
            log.error("Error: "+e.getMessage());
        }
        System.exit(0);
    }
}
