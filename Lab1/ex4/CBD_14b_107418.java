package ex4;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Scanner;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.params.ScanParams;
import redis.clients.jedis.resps.Tuple;

public class CBD_14b_107418 {
    public static void main(String[] args) {
        Scanner sc;
        Jedis jedis = new Jedis();
        try {
            sc = new Scanner(new File("ex4/nomes-pt-2021.csv"));

            while (sc.hasNextLine()) {
                jedis.zadd("NamesScore", 0, sc.nextLine());
            }
            sc.close();
        } catch (FileNotFoundException e) {
            System.err.println("Error: nomes-pt-2021.csv file not found");
            return;
        }

        // fill the set

        // prepare the reader for the output file:
        PrintWriter pw;
        try {
            pw = new PrintWriter("ex4/CBD-14b-out-107418.txt");

            // handle User input
            sc = new Scanner(System.in);

            while (true) {
                System.out.print("Search for ('Enter' for quit): ");
                pw.print("Search for ('Enter' for quit): ");

                String input = sc.nextLine();
                pw.println(input);

                if (input.length() == 0) {
                    break;
                }

                Map<String, Integer> results = new HashMap<>();
                for (String s : jedis.zrangeByLex("NamesScore", "[" + input, "[" + input + (char) 0XFF)) {
                    String[] parts = s.split("[;,_. ]");
                    if (parts.length != 2) {
                        System.err.println("Error:invalid format");
                        return;
                    }
                    results.put(parts[0], Integer.parseInt(parts[1]));
                }
                results.entrySet().stream().sorted((e1, e2) -> e2.getValue().compareTo(e1.getValue()))
                        .forEach(entry -> {
                            System.out.println(entry.getKey());
                            pw.println(entry.getKey());
                        });

                System.out.printf("\n");
                pw.printf("\n");
            }
            pw.close();
            sc.close();

        } catch (FileNotFoundException e) {
            System.err.println("Error creating file");
        }

        jedis.close();

    }
}
