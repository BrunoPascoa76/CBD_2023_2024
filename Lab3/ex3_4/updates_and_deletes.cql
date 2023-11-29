USE company;

//updates
UPDATE user SET password='you_got_hacked' WHERE username='ehammelberg0';
UPDATE location SET stock[209]=0 WHERE address='82 Mariners Cove Hill';
UPDATE user SET orders=[] WHERE username='ehammelberg0';
UPDATE user SET orders=orders+[20] WHERE username='ehammelberg0';
UPDATE product SET product_name='generic name' WHERE product_id=1;

//deletes
DELETE stock[209] FROM location WHERE address='82 Mariners Cove Hill';
DELETE FROM location WHERE address='82 Mariners Cove Hill';
DELETE orders[39] FROM user WHERE username='ehammelberg0' AND password='$2a$04$H68ssC2tz8.PqC5EUzZDy.A8955HT5aqFo2A1R8KsBhLlyoOzTyb6';
BEGIN BATCH
DELETE FROM product WHERE product_id=1;
DELETE FROM user WHERE username='ehammelberg0' AND password='$2a$04$H68ssC2tz8.PqC5EUzZDy.A8955HT5aqFo2A1R8KsBhLlyoOzTyb6';
DELETE FROM review WHERE reviewer='ehammelberg0';
APPLY BATCH;
