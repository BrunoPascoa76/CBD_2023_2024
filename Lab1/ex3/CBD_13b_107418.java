package ex3;

import java.util.HashMap;
import java.util.Map;

import redis.clients.jedis.Jedis;

public class CBD_13b_107418 {
    public static void main(String[] args) {
        // Ensure you have redis-server running
        Jedis jedis = new Jedis();
        String[] usersList = { "Ana", "Pedro", "Maria", "Bruno" };
        Map<String, String> usersMap = new HashMap<>();
        usersMap.put("Ana", "Mendonça");
        usersMap.put("Pedro", "Nogueira");
        usersMap.put("Maria", "Madalena");
        usersMap.put("Bruno", "Páscoa");

        // I)
        jedis.lpush("List", usersList);
        System.out.println(jedis.llen("List"));
        // FIFO
        for (int i = 0; i < 4; i++) {
            System.out.println(jedis.rpop("List"));
        }

        // II)
        jedis.hset("Hash", usersMap);

        System.out.println(jedis.hkeys("Hash"));

        System.out.println(jedis.hget("Hash", "Ana"));

        jedis.close();
    }
}