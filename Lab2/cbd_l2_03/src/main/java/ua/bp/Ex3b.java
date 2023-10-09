package ua.bp;

import java.util.Arrays;

import org.bson.Document;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Indexes;

public class Ex3b {
    public static void main(String[] args){
        long timeBefore;
        MongoCollection<Document> restaurants=MongoClients
            .create("mongodb://localhost:27017")
            .getDatabase("cbd")
            .getCollection("restaurants");
            
        final int TIMES_TO_REPEAT=10000;
        //to try to bump up the times, I'll try to repeat the queries
        System.out.println("Sem índice:");    

        timeBefore=System.currentTimeMillis();
        for(int i=0;i<TIMES_TO_REPEAT;i++){
            restaurants.find(new Document("localidade","Brooklyn"));
        }
        System.out.println("localidade: "+(System.currentTimeMillis()-timeBefore));


        timeBefore=System.currentTimeMillis();
        for(int i=0;i<TIMES_TO_REPEAT;i++){
            restaurants.find(new Document("gastronomia","American"));
        }
        System.out.println("gastronomia: "+(System.currentTimeMillis()-timeBefore));

        timeBefore=System.currentTimeMillis();
        for(int i=0;i<TIMES_TO_REPEAT;i++){
             restaurants.find(new Document("$text",new Document("$search","restaurant")
        ));
        }
        System.out.println("nome: "+(System.currentTimeMillis()-timeBefore));
        
        restaurants.createIndex(Indexes.ascending("localidade"));
        restaurants.createIndex(Indexes.ascending("gastronomia"));
        restaurants.createIndex(Indexes.text("nome"));


        System.out.println("\nCom índice:");    

        timeBefore=System.currentTimeMillis();
        for(int i=0;i<TIMES_TO_REPEAT;i++){
            restaurants.find(new Document("localidade","Brooklyn"));
        }
        System.out.println("localidade: "+(System.currentTimeMillis()-timeBefore));


        timeBefore=System.currentTimeMillis();
        for(int i=0;i<TIMES_TO_REPEAT;i++){
            restaurants.find(new Document("gastronomia","American"));
        }
        System.out.println("gastronomia: "+(System.currentTimeMillis()-timeBefore));

        timeBefore=System.currentTimeMillis();
        for(int i=0;i<TIMES_TO_REPEAT;i++){
            restaurants.find(new Document("$text",new Document("$search","restaurant")
        ));
        }
        System.out.println("nome: "+(System.currentTimeMillis()-timeBefore)); //I don't know why but it's consistently taking longer with index. Perhaps it hurts more than it helps on smaller strings


        //resetting to allow for repeatability:
        restaurants.dropIndex("localidade_1");
        restaurants.dropIndex("gastronomia_1");
        restaurants.dropIndex("nome_text");

        System.exit(0);
    }
}
