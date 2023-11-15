CREATE KEYSPACE IF NOT EXISTS Video_Sharing WITH REPLICATION = {'class':'SimpleStrategy','replication_factor':1};

USE Video_Sharing;

CREATE TABLE IF NOT EXISTS user (
    username text,
    email text,
    register_date timestamp,
    PRIMARY KEY(username)
);

CREATE TABLE IF NOT EXISTS video(
    author text,
    name text,
    description text,
    tags list<text>,
    upload_date timestamp,
    duration int,
    Primary KEY(author,name)
);

CREATE TABLE IF NOT EXISTS follower(
    video_name text PRIMARY KEY,
    followers list<text>
);

CREATE TABLE IF NOT EXISTS comment(
    video_name text,
    author text,
    comment text,
    timestamp timestamp,
    PRIMARY KEY (video_name,timestamp,author)
);


CREATE TABLE IF NOT EXISTS event(
    video_name text,
    username text,
    event_name text,
    timestamp timestamp,
    video_moment int,
    PRIMARY KEY ((video_name,username),timestamp)
);

CREATE TABLE IF NOT EXISTS rating(
    video_name text,
    value int,
    PRIMARY KEY (video_name,value)
);

