CREATE TABLE song_list (
    song_id VARCHAR PRIMARY KEY,
    song_name VARCHAR,
    artist VARCHAR,
    album VARCHAR,
    runtime_seconds INTEGER
);

CREATE TABLE hip_hop_track_list (
    track_uri VARCHAR,
    track_name VARCHAR,
    song_tracking_id VARCHAR REFERENCES song_list(song_id),
    album_name VARCHAR,
    artist_name VARCHAR,
    release_date VARCHAR,
    duration_ms INTEGER,
    popularity INTEGER,
    explicit BOOLEAN,
    added_by VARCHAR,
    added_at VARCHAR,
    genres VARCHAR,
    record_label VARCHAR,
    danceability FLOAT,
    energy FLOAT,
    key INTEGER,
    loudness FLOAT,
    mode INTEGER,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    time_signature INTEGER
);

CREATE TABLE sample_list (
    sample_id VARCHAR PRIMARY KEY,
    song_id VARCHAR REFERENCES song_list(song_id),
    track_uri VARCHAR,
    track_name VARCHAR,
    album_name VARCHAR,
    artist_name VARCHAR,
    release_date VARCHAR,
    duration_ms INTEGER,
    popularity INTEGER,
    explicit BOOLEAN,
    added_by VARCHAR,
    added_at VARCHAR,
    genres VARCHAR,
    record_label VARCHAR,
    danceability FLOAT,
    energy FLOAT,
    key INTEGER,
    loudness FLOAT,
    mode INTEGER,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    time_signature INTEGER
);

COPY song_list FROM '../data/song_list.csv' (FORMAT CSV, HEADER TRUE);
COPY hip_hop_track_list FROM '../data/hip_hop_track_list.csv' (FORMAT CSV, HEADER TRUE);
COPY sample_list FROM '../data/sample_list.csv' (FORMAT CSV, HEADER TRUE);


SELECT
    h.track_name,
    h.artist_name,
    h.duration_ms / 1000.0 AS duration_seconds
FROM hip_hop_track_list h
ORDER BY duration_seconds DESC
LIMIT 10;

SELECT h.track_name, h.artist_name, h.duration_ms / 1000.0 AS track_duration_seconds,
    COALESCE(SUM(sa.duration_ms), 0) / 1000.0 AS sample_duration_seconds,
    (h.duration_ms + COALESCE(SUM(sa.duration_ms), 0)) / 1000.0 AS total_duration_seconds
FROM hip_hop_track_list h
LEFT JOIN sample_list sa ON sa.song_id = h.song_tracking_id
GROUP BY h.track_name, h.artist_name, h.duration_ms
ORDER BY total_duration_seconds DESC
LIMIT 10;

SHOW TABLES;