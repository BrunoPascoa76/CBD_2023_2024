package ex6;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import redis.clients.jedis.Jedis;

public class CBD_16_107418 {
    public static void main(String[] args) {

    }
}

class MessageManager {
    private Jedis jedis;
    private String user;

    public MessageManager(Jedis jedis, String user) {
        this.user = user;
        this.jedis = jedis;
    }

    public void postMessage(String message) {
        Set<String> subscribers = getSubscribers();
        for (String subscriber : subscribers) {
            jedis.rpush(subscriber + ":" + user, message);
        }
    }

    public Map<String, List<String>> getMessages() {
        Set<String> subscriptions = jedis.smembers(user + ":subscriptions");
        Map<String, List<String>> messages = new HashMap<>();
        for (String subscription : subscriptions) {
            messages.put(subscription, getMessages(subscription));
        }
        return messages;
    }

    public List<String> getMessages(String target) {
        List<String> result = jedis.lrange(user + ":" + target, 0, -1);
        jedis.del(user + ":" + target);
        return result;
    }

    public void subscribe(String target) {
        jedis.sadd(this.user + ":subscriptions", user);
        jedis.sadd(target + ":subscribers", this.user);
    }

    public void unsubscribe(String target) {
        jedis.srem(user + ":subscriptions", target);
        jedis.srem(target + ":subscribers", user);

    }

    public Set<String> getSubscribers() {
        return jedis.smembers(user + ":subscribers");
    }

    public Set<String> getSubscriptions() {
        return jedis.smembers(user + ":subscriptions");
    }
}