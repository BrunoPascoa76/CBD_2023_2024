package ex3;

import redis.clients.jedis.Jedis;

public class CBD_13a_107418 {
    public static void main(String[] args) {
        Jedis jedis = new Jedis();

        jedis.set("a", "b");
        System.out.println(jedis.get("a"));

        jedis.lpush("list", "a", "b", "c", "d");
        System.out.println(jedis.lpop("list"));

        jedis.close();
    }
}
