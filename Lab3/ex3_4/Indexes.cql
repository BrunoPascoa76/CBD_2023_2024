USE company;

CREATE INDEX ON user(orders);
CREATE INDEX ON product(reviews);
CREATE INDEX order_product on "order"(KEYS(products));
CREATE INDEX ON location(ENTRIES (stock));
CREATE INDEX ON review(rating);