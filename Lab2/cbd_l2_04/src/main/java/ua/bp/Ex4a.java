package ua.bp;

import java.util.Arrays;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.mongodb.MongoException;

public class Ex4a 
{
    public static void main( String[] args ) throws InterruptedException
    {
        System.setProperty("logFilename","CBD_L204-out_107418");
        Logger log=LogManager.getLogger("ex4a");
        final int MAX_AMOUNT=3;
        final long TTL=10;
        final String user1="José";
        final String user2="Maria";
        final String insertionMessage="%s) Inserting product %s (X%d)...";

        OrderManager manager;
        List<Order> orders=Arrays.asList(
            new Order("Comida para cão",2),
            new Order("Comidade para gato",4),
            new Order("Comida para peixe",1),
            new Order("Comida para mim",5)
        );
        log.info("Variables:\n\tMAX_AMOUNT="+MAX_AMOUNT+"\n\tTTL="+TTL+"\n\tuser1="+user1+"\n\tuser2="+user2);

        try{
            log.debug("Creating manager...");
            manager=new OrderManager(TTL,MAX_AMOUNT);
        
            log.debug("Testing insertions (last one should fail):");
            for(Order order: orders){
                log.info(insertionMessage.format(user1,order.product_name(),order.amount()));
                if(manager.insertOrderLimitProduct(user1, order)){
                    log.info("Insertion successful");
                }else{
                    log.warn("Insertion failed");
                }
            }

            log.debug("Testing insertion with other user (should succeed):");
            log.info(insertionMessage.format(user2,orders.get(0).product_name(),orders.get(0).amount()));
            if(manager.insertOrderLimitProduct(user2, orders.get(0))){
                log.info("Insertion successful");
            }else{
                log.warn("Insertion failed");
            }

            log.debug("Testing after waiting for TTL to expire (should succeed):");
            Thread.sleep(TTL*1000);
            log.info(insertionMessage.format(user1,orders.get(3).product_name(),orders.get(4).amount()));
            if(manager.insertOrderLimitProduct(user1, orders.get(3))){
                log.info("Insertion successful");
            }else{
                log.warn("Insertion failed");
            }



        }catch(MongoException e){
            log.error("Error: "+e.getMessage());
        }
        System.exit(0);
    }
}
