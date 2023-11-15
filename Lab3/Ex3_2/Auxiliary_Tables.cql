CREATE TABLE IF NOT EXISTS comment_by_user(
    video_name text,
    author text,
    comment text,
    timestamp timestamp,
    PRIMARY KEY (author,timestamp,video_name)
);

//From now forward, I'll copy between tables using the COPY command
CREATE TABLE IF NOT EXISTS video_by_name(
    author text,
    name text,
    description text,
    tags list<text>,
    upload_date timestamp,
    duration int,
    Primary KEY(name)
);

CREATE INDEX vdate ON video(upload_date);

CREATE TABLE user_following(
    username text PRIMARY KEY ,
    videos List<text>
);

