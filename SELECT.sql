SELECT
    h."Track Name",
    h."Artist Name(s)",
    h."Duration (ms)"
FROM hip_hop_track_list h
JOIN song_list s ON h.song_tracking_id = s.SongID
ORDER BY h."Duration (ms)" DESC
LIMIT 10;