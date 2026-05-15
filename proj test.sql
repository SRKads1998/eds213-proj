-- lab 3 Create tables
CREATE TABLE samples (
    sample_id VARCHAR,
    song_id VARCHAR,
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

CREATE TABLE hip_hop_tracks (
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

CREATE TABLE sample_set (
    song_id VARCHAR,
    song_name VARCHAR,
    artist VARCHAR,
    album VARCHAR,
    runtime_seconds INTEGER
);

-- Load data
COPY samples FROM 'data/213_Sample_List.csv' (FORMAT CSV, HEADER TRUE);
COPY hip_hop_tracks FROM 'data/hip_hop_track_list.csv' (FORMAT CSV, HEADER TRUE);
COPY sample_set FROM 'data/sample_set_test.csv' (FORMAT CSV, HEADER TRUE);



-- test with join

SELECT 
    ss.song_name,
    ss.artist,
    s.popularity,
    s.danceability
FROM sample_set ss
JOIN samples s ON ss.song_id = s.song_id
LIMIT 10;

SELECT 
    h.track_name,
    h.duration_ms,
    s.song_id
FROM hip_hop_tracks h
JOIN samples s ON h.track_uri = s.track_uri
LIMIT 5;

SELECT track_uri FROM hip_hop_tracks LIMIT 3;
SELECT track_uri FROM samples LIMIT 3;
-- lab 4

SELECT rowid, track_name FROM hip_hop_tracks ORDER BY rowid LIMIT 5;
SELECT rowid, song_id, track_name FROM samples ORDER BY rowid LIMIT 5;

SELECT song_id, track_name FROM sample_set LIMIT 5;

SELECT song_id, song_name FROM sample_set LIMIT 5;

SELECT 
    ss.song_name,
    ss.runtime_seconds AS hiphop_runtime,
    SUM(h.duration_ms / 1000) AS total_sample_runtime,
    ss.runtime_seconds + SUM(h.duration_ms / 1000) AS cumulative_runtime
FROM sample_set ss
JOIN samples s ON ss.song_id = s.song_id
JOIN hip_hop_tracks h ON s.track_uri = h.track_uri
GROUP BY ss.song_name, ss.runtime_seconds;

SELECT sample_id, song_id, track_name FROM samples LIMIT 5;

SELECT s.song_id, s.track_name, h.duration_ms
FROM samples s
JOIN hip_hop_tracks h ON s.track_name = h.track_name
LIMIT 5;

SELECT s.track_name AS sample_name, h.track_name AS hiphop_name
FROM samples s
LEFT JOIN hip_hop_tracks h ON s.track_name = h.track_name
WHERE h.track_name IS NULL
LIMIT 5;

SELECT track_name FROM hip_hop_tracks LIMIT 10;

DESCRIBE samples;

SELECT 
    ss.song_name,
    ss.runtime_seconds AS hiphop_runtime,
    SUM(s.duration_ms / 1000) AS total_sample_runtime,
    ss.runtime_seconds + SUM(s.duration_ms / 1000) AS cumulative_runtime
FROM sample_set ss
JOIN samples s ON ss.song_id = s.song_id
GROUP BY ss.song_name, ss.runtime_seconds;