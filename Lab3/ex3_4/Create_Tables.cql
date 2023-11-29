// This database will focus on product/order management for a multi-store company

CREATE KEYSPACE IF NOT EXISTS company WITH REPLICATION = {'class':'SimpleStrategy','replication_factor':1};

USE company;

CREATE TABLE IF NOT EXISTS user(
    user_id int,
    username text,
    password text,
    orders list<int>,
    PRIMARY KEY (user_id,username,password)
);

CREATE TABLE IF NOT EXISTS product(
    product_id int,
    product_name text,
    price float,
    reviews set<int>,
    PRIMARY KEY ( product_id,product_name)
);

CREATE TABLE IF NOT EXISTS review(
    reviewer int,
    rating int,
    comment text,
    date timestamp,
    PRIMARY KEY (reviewer,date)
);

CREATE TABLE IF NOT EXISTS "order"(
    order_id int,
    products map<int,int>,
    PRIMARY KEY (order_id)
);

CREATE TABLE location (
    address text PRIMARY KEY,
    stock map<int,int>
);