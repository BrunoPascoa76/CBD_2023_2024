package ua.bp;

import java.net.InetSocketAddress;

import com.datastax.oss.driver.api.core.ConsistencyLevel;
import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.SimpleStatement;
import com.datastax.oss.driver.api.core.type.DataTypes;
import com.datastax.oss.driver.api.querybuilder.QueryBuilder;
import com.datastax.oss.driver.api.querybuilder.SchemaBuilder;
import com.datastax.oss.driver.api.querybuilder.insert.RegularInsert;
import com.datastax.oss.driver.api.querybuilder.schema.CreateKeyspace;
import com.datastax.oss.driver.api.querybuilder.schema.CreateTable;
import com.datastax.oss.driver.api.querybuilder.select.Select;

public class Ex3_a{
    public static void main(String[] args){
        CqlSession session=CqlSession.builder().addContactPoint(new InetSocketAddress("127.0.0.1",9042)).withLocalDatacenter("datacenter1").build();

        CreateKeyspace ck=SchemaBuilder
            .createKeyspace("test_keyspace")
            .ifNotExists()
            .withSimpleStrategy(1);
        session.execute(ck.build());
        session.execute("use test_keyspace");

        CreateTable t=SchemaBuilder
            .createTable("test")
            .ifNotExists()
            .withPartitionKey("id", DataTypes.INT)
            .withClusteringColumn("name", DataTypes.TEXT);
        session.execute(t.build());
        
        SimpleStatement insert = QueryBuilder.insertInto("test").value("id",QueryBuilder.bindMarker()).value("name",QueryBuilder.bindMarker()).build();
        session.execute(session.prepare(insert).bind().setInt("id",1).setString("name","Bruno"));
        session.execute(session.prepare(insert).bind().setInt("id",2).setString("name","José"));        
        
        Select select=QueryBuilder.selectFrom("test").all();
        session.execute(select.build()).forEach(x->
            System.out.printf("id: %d name %s \n",x.getInt("id"),x.getString("name"))
        );

        session.close();
        System.exit(0);
    }
}
