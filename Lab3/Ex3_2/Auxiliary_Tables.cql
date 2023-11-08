CREATE TABLE IF NOT EXISTS comment_by_user(
    video_name text,
    author text,
    comment text,
    timestamp timestamp,
    PRIMARY KEY (author,timestamp,video_name)
);