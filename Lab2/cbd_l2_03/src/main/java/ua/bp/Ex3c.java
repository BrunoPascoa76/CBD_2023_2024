package ua.bp;

import java.time.LocalDateTime;
import java.util.Arrays;

import org.bson.Document;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.Accumulators;
import com.mongodb.client.model.Aggregates;

public class Ex3c {
    public static void main(String[] args){
        MongoCollection<Document> restaurants=MongoClients
            .create("mongodb://localhost:27017")
            .getDatabase("cbd")
            .getCollection("restaurants");

        // 12. Liste o restaurant_id, o nome, a localidade e a gastronomia dos restaurantes localizados em "Staten Island", "Queens", ou "Brooklyn".
        System.out.println("Exercício 12:");
        restaurants.find(
            new Document("localidade",new Document("$in",Arrays.asList("Staten Island","Queens","Brooklyn")))
        ).projection(
            new Document("_id",false)
            .append("nome",true)
            .append("localidade",true)
            .append("gastronomia",true)
        ).forEach(d->System.out.println(d.toJson()));
        
        // 15. Liste o restaurant_id, o nome e os score dos restaurantes nos quais a segunda avaliação foi grade "A" e ocorreu em ISODATE "2014-08-11T00: 00: 00Z".
        System.out.println("Exercício 15: ");
        restaurants.find(
            new Document("grades.1.grade","A")
            .append("grades.1.date",LocalDateTime.of(2014,8,11,0,0,0))
            ).projection(
                new Document("_id",false)
                .append("restaurant_id",true)
                .append("nome",true)
                .append("grades.score",true)
            ).forEach(d->System.out.println(d.toJson()));
        
        // 17. Liste nome, gastronomia e localidade de todos os restaurantes ordenando por ordem crescente da gastronomia e, em segundo, por ordem decrescente de localidade.
        System.out.println("Exercício 17:");
        restaurants.find().projection(
            new Document("_id",false)
            .append("nome",true)
            .append("gastronomia",true)
            .append("localidade",true)
        ).sort(
            new Document("gastronomia",1)
            .append("localidade",-1)
        ).forEach(d->System.out.println(d.toJson()));
        
        
        // 18. Liste nome, localidade, grade e gastronomia de todos os restaurantes localizados em Brooklyn que não incluem gastronomia "American" e obtiveram uma classificação (grade) "A". Deve apresentá-los por ordem decrescente de gastronomia.
        System.out.println("\nExercício 18:");
        restaurants.find(
            new Document("localidade","Brooklyn")
            .append("gastronomia",new Document("$ne","American"))
            .append("grades",new Document("$elemMatch",new Document("grade","A")))
        ).projection(
            new Document("_id",false)
            .append("nome",true)
            .append("localidade",true)
            .append("grades.grade",true)
            .append("gastronomia",true)      
        ).forEach(d->System.out.println(d.toJson()));

        // 24. Apresente o número de gastronomias diferentes na rua "Fifth Avenue"
        System.out.println("\nExercício 24:");
        restaurants.aggregate(Arrays.asList(
            new Document("$match", new Document("address.rua", "Fifth Avenue")),
            new Document("$group", new Document("_id", "$address.rua")
                .append("distinctGastronomias", new Document("$addToSet", "$gastronomia"))),
            new Document("$project", new Document("_id", 1)
                .append("numGastronomias", new Document("$size", "$distinctGastronomias")))
        )).forEach(d->System.out.println(d.toJson()));
        
        System.exit(0);
    }
}
