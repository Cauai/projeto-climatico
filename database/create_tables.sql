CREATE TABLE IF NOT EXISTS weather_events (
    id SERIAL PRIMARY KEY,
    station_name,
    event_timestamp TIMESTAMP,
    temperature FLOAT,
    humidity FLOAT,
    precipitation FLOAT,
    wind_speed FLOAT,
    created_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);