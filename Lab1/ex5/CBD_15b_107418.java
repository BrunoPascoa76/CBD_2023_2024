package ex5;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.stream.Collectors;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.params.ScanParams;
import redis.clients.jedis.resps.ScanResult;

public class CBD_15b_107418 {

    public static void main(String[] args) {
        final int TTL = 10;
        final int MAX_AMOUNT = 3;
        try {
            Jedis jedis = new Jedis();
            PrintWriter pw = new PrintWriter("ex5/CBD-15b-out-107418.txt");

            pw.println("TTL used: " + TTL + "s");
            pw.println("Number of items allowed: " + MAX_AMOUNT);

            pw.println("Inserting item1(x4)...");
            if (insertItem("user1", "item1", 4, jedis, MAX_AMOUNT, TTL)) {
                pw.println("Item inserted successfully");
            } else {
                pw.println("Item not inserted");
            }

            pw.println("Inserting item2(x2)...");
            if (insertItem("user1", "item2", 2, jedis, MAX_AMOUNT, TTL)) {
                pw.println("Item inserted successfully");
            } else {
                pw.println("Item not inserted");
            }

            pw.println("Inserting item3(x2)...");
            if (insertItem("user1", "item3", 2, jedis, MAX_AMOUNT, TTL)) {
                pw.println("Item inserted successfully");
            } else {
                pw.println("Item not inserted");
            }

            pw.println("Inserting item4(x1)...");
            if (insertItem("user1", "item4", 1, jedis, MAX_AMOUNT, TTL)) {
                pw.println("Item inserted successfully");
            } else {
                pw.println("Item not inserted");
            }

            pw.println("Inserting item5(x1)...");
            if (insertItem("user1", "item5", 1, jedis, MAX_AMOUNT, TTL)) {
                pw.println("Item inserted successfully");
            } else {
                pw.println("Item not inserted");
            }

            try {
                pw.println("Waiting for TTL to expire...");
                Thread.sleep(TTL * 1000);
            } catch (Exception e) {
                System.err.println(e);
            }

            pw.println("Inserting item6(x3)...");
            if (insertItem("user1", "item6", 3, jedis, MAX_AMOUNT, TTL)) {
                pw.println("Item inserted successfully");
            } else {
                pw.println("Item not inserted");
            }

            pw.close();

        } catch (IOException e) {
            System.err.println("Error: " + e.getMessage());
        }
    }

    public static boolean insertItem(String username, String item, int amount, Jedis jedis, int numRequests, int ttl) {
        if (isFull(username, jedis, numRequests, amount)) {
            return false;
        } else {
            jedis.incrBy(username + "_" + item, amount); // increment by amount
            jedis.expire(username + "_" + item, ttl); // set/reset TTL
            return true;
        }
    }

    public static boolean isFull(String username, Jedis jedis, int maxAmount, int requestNum) {
        ScanResult<String> result = jedis.scan(ScanParams.SCAN_POINTER_START, new ScanParams().match(username + "_*"));
        int count = requestNum;
        count += result.getResult().stream().map((String key) -> Integer.parseInt(jedis.get(key)))
                .collect(Collectors.summingInt(Integer::intValue)); // add the sum of each product's quantity
        return count > maxAmount;
    }
}
