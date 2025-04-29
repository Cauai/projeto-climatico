-- Criação da tabela
CREATE TABLE IF NOT EXISTS weather_events (
    id SERIAL PRIMARY KEY,
    station_name VARCHAR(50),
    event_timestamp TIMESTAMP,
    temperature FLOAT,
    humidity FLOAT,
    precipitation FLOAT,
    wind_speed FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
