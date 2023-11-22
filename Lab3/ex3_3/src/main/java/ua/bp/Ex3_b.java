package ua.bp;

import java.net.InetSocketAddress;
import java.sql.Timestamp;
import java.util.Date;

import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.SimpleStatement;
import com.datastax.oss.driver.api.core.cql.Statement;
import com.datastax.oss.driver.api.querybuilder.QueryBuilder;
import com.datastax.oss.driver.api.querybuilder.select.Select;

public class Ex3_b {
    public static void main(String[] args){
        CqlSession session=CqlSession.builder().addContactPoint(new InetSocketAddress("127.0.0.1",9042)).withLocalDatacenter("datacenter1").build();
        session.execute("use Video_Sharing;");

        // 4. Os últimos 5 eventos de determinado vídeo realizados por um utilizador;
        System.out.printf("\nEx4: \n");
        Statement select4= SimpleStatement.newInstance("SELECT * FROM event WHERE username='cpond9' AND video_name='Superheroes' ORDER BY timestamp DESC LIMIT 5;");
        session.execute(select4).forEach(
            x->System.out.printf(
                "{\n video_name: %s,\n username: %s,\n event_name: %s,\n timestamp: %s,\n video_moment: %ds\n}\n",
                x.getString("video_name"),
                x.getString("username"),
                x.getString("event_name"),
                x.getInstant("timestamp"),
                x.getInt("video_moment")
        )); 

        // 7. Todos os seguidores (followers) de determinado vídeo;
        System.out.printf("\nEx7: \n");
        Select select7 =  QueryBuilder.selectFrom("follower").column("followers").whereColumn("video_name").isEqualTo(QueryBuilder.literal("Superheroes"));
        session.execute(select7.build()).forEach(x->System.out.println(x.getList("followers",String.class)));
        
        // 12. Get the max, min and average and number of ratings of every (rated) video
        System.out.printf("\nEx12:\n");
        Statement select12 = SimpleStatement.newInstance("SELECT video_name, count(*) AS total_ratings, min(value) AS worst_rating,avg(value) as average_rating, max(value) AS best_rating FROM rating GROUP BY video_name;");
        session.execute(select12).forEach(
            x->System.out.printf(
                "{\n video_name: %s,\n total_ratings: %d,\n worst_rating: %d,\n average_rating: %d,\n best_rating: %d\n}\n",
                x.getString("video_name"),
                x.getLong("total_ratings"),
                x.getInt("worst_rating"),
                x.getInt("average_rating"),
                x.getInt("best_rating")
        )); 

        
        // 13. For each video, for each user, count the number of events
        System.out.printf("\nEx13:\n");
        Statement select13 = SimpleStatement.newInstance("SELECT video_name,username,count(event_name) AS num_events FROM event GROUP BY video_name,username;");
        session.execute(select13).forEach(
            x->System.out.printf("{\n video_name: %s,\n username: %s,\n num_events: %d\n}\n",
                x.getString("video_name"),
                x.getString("username"),
                x.getLong(2)
        ));

        session.close();
        System.exit(0);
    }
}
