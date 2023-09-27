package ex4;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Scanner;
import redis.clients.jedis.Jedis;

public class CBD_14a_107418 {
    public static void main(String[] args) {
        Scanner sc;
        Jedis jedis = new Jedis();
        try {
            sc = new Scanner(new File("ex4/names.txt"));

            while (sc.hasNextLine()) {
                jedis.zadd("NamesLex", 0, sc.nextLine());
            }
            sc.close();
        } catch (FileNotFoundException e) {
            System.err.println("Error: names.txt file not found");
            return;
        }

        // fill the set

        // prepare the reader for the output file:
        PrintWriter pw;
        try {
            pw = new PrintWriter("ex4/CBD-14a-out-107418.txt");

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

                // The function for this case is ZRANGEBYLEX, but since it requires both a min
                // and a max values (and it doesn't seem we can use patterns), I'll just use as
                // max input + xFF (highest value a byte can take)
                for (String s : jedis.zrangeByLex("NamesLex", "[" + input, "[" + input + (char) 0XFF)) {
                    System.out.println(s);
                    pw.println(s);
                }
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
