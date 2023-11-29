USE company;

SELECT * FROM user;
SELECT password AS random_string FROM user;
SELECT * FROM user WHERE user_id=2;
SELECT * FROM product;
SELECT * FROM review WHERE reviewer=1 ORDER BY date;
SELECT min(price) AS min_price, max(price) AS max_price, avg(price) AS average_price FROM product;
SELECT reviewer,count(*) AS num_comments FROM review GROUP BY reviewer;
SELECT * from "order" WHERE products CONTAINS KEY 1;
SELECT * FROM "location" WHERE stock[29]=7;
SELECT * FROM user WHERE orders CONTAINS 4;