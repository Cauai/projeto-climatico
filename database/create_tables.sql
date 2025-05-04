CREATE TABLE IF NOT EXISTS weather_events (
    id SERIAL PRIMARY KEY,
    station_name VARCHAR(50),
    event_timestamp TIMESTAMP,
    temperature FLOAT,
    humidity FLOAT,
    wind_speed FLOAT,
    precipitation FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

