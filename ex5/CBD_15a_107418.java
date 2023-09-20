package ex5;

import java.io.IOException;
import java.io.PrintWriter;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.params.ScanParams;
import redis.clients.jedis.resps.ScanResult;

public class CBD_15a_107418 {

    public static void main(String[] args) {
        final int TTL = 10;
        final int NUM_REQUESTS = 3;
        try {
            Jedis jedis = new Jedis();
            PrintWriter pw = new PrintWriter("ex5/CBD-15a-out-107418.txt");

            pw.println("TTL used: " + TTL + "s");
            pw.println("Number of requests allowed: " + NUM_REQUESTS);

            for (int i = 0; i < NUM_REQUESTS + 1; i++) {
                pw.println("Inserting item" + i + "...");
                if (insertItem("user1", "item" + i, 1, jedis, NUM_REQUESTS, TTL)) {
                    pw.println("Item inserted successfully");
                } else {
                    pw.println("Item not inserted");
                    break;
                }
            }

            try {
                pw.println("Waiting for TTL to expire...");
                Thread.sleep(TTL * 1000);
            } catch (Exception e) {
                System.err.println(e);
            }

            pw.println("Inserting item" + (NUM_REQUESTS + 1) + "...");
            if (insertItem("user1", "item" + (NUM_REQUESTS + 1), 1, jedis, NUM_REQUESTS, TTL)) {
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
        if (isFull(username, jedis, numRequests)) {
            return false;
        } else {
            jedis.incrBy(username + "_" + item, amount); // increment by amount
            jedis.expire(username + "_" + item, ttl); // set/reset TTL
            return true;
        }
    }

    public static boolean isFull(String username, Jedis jedis, int numRequests) {
        ScanResult<String> result = jedis.scan(ScanParams.SCAN_POINTER_START, new ScanParams().match(username + "_*"));
        return result.getResult().size() >= numRequests;
    }
}
