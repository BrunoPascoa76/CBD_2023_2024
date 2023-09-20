package ex6;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.params.ScanParams;

public class CBD_16_107418 {
    public static void main(String[] args) {
        try {
            PrintWriter pw = new PrintWriter("ex6/CBD-16-out-107418.txt");
            Jedis jedis = new Jedis();
            MessageManager mm = new MessageManager(jedis);

            mm.addUser("UserA");
            pw.println("UserA added");
            mm.addUser("UserB");
            pw.println("UserB added");
            mm.addUser("UserC");
            pw.println("UserC added");

            mm.subscribe("UserA", "UserB");
            pw.println("UserA subscribed to UserB");

            mm.publish("UserB", "Hello World");
            pw.println("UserB published 'Hello World'");

            pw.println("UserA's messages:");
            mm.fetchAllMessages("UserA").entrySet().forEach(entry -> {
                pw.println(entry.getKey() + ": " + entry.getValue());
            });

            pw.println("UserC's messages:");
            mm.fetchAllMessages("UserC").entrySet().forEach(entry -> {
                pw.println(entry.getKey() + ": " + entry.getValue());
            });

            pw.close();
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
    }
}

class MessageManager {
    private Jedis jedis;

    public MessageManager(Jedis jedis) {
        this.jedis = jedis;
    }

    public void addUser(String username) {
        jedis.sadd("users", username);
    }

    public boolean isUser(String username) {
        return jedis.sismember("users", username);
    }

    public Set<String> listUsers() {
        return jedis.smembers("users");
    }

    public void subscribe(String user1, String user2) {
        if (isUser(user1) && isUser(user2) && !jedis.sismember(user2 + ":blocked", user1)) {
            jedis.sadd(user2 + ":followers", user1);
        }
    }

    public void unsubscribe(String user1, String user2) {
        if (isUser(user1) && isUser(user2) && jedis.sismember(user2 + ":followers", user1)) {
            jedis.srem(user2 + ":followers", user1);
        }
    }

    public void publish(String user, String message) {
        if (isUser(user)) {
            jedis.smembers(user + ":followers").stream()
                    .forEach(follower -> jedis.lpush(follower + ":" + user, message));
        }
    }

    public Map<String, List<String>> fetchAllMessages(String user) {
        Map<String, List<String>> messages = new HashMap<>();
        if (isUser(user)) {
            List<String> following = jedis.scan(ScanParams.SCAN_POINTER_START, new ScanParams().match(user + ":*"))
                    .getResult();

            for (String lst : following) {
                messages.put(lst.split(":")[1], fetchMessages(user, lst.split(":")[1]));
            }
        }
        return messages;
    }

    public List<String> fetchMessages(String user1, String user2) {
        if (isUser(user1) && isUser(user2) && jedis.exists(user1 + ":" + user2)) {
            List<String> messages = jedis.lrange(user1 + ":" + user2, 0, -1);
            jedis.del(user1 + ":" + user2);
            return messages;
        } else {
            return new ArrayList<>();
        }
    }

    public void block(String user1, String user2) {
        if (isUser(user1) && isUser(user2)) {
            jedis.sadd(user1 + ":blocked", user2);
            jedis.del(user1 + ":" + user2);
            jedis.srem(user1 + ":followers", user2);
        }
    }

    public void unblock(String user1, String user2) {
        if (isUser(user1) && isUser(user2)) {
            jedis.srem(user1 + ":blocked", user2);
        }
    }
}