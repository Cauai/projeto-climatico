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

-- Inserindo dados sintéticos
INSERT INTO weather_events (station_name, event_timestamp, temperature, humidity, precipitation, wind_speed)
VALUES
('Estacao_Sao_Paulo', NOW() - INTERVAL '10 minutes', 26.5, 70.0, 0.0, 15.2),
('Estacao_Rio_de_Janeiro', NOW() - INTERVAL '20 minutes', 29.1, 65.0, 0.0, 12.0),
('Estacao_Belo_Horizonte', NOW() - INTERVAL '30 minutes', 25.0, 75.0, 1.2, 9.8),
('Estacao_Curitiba', NOW() - INTERVAL '40 minutes', 22.3, 80.0, 0.5, 20.1),
('Estacao_Porto_Alegre', NOW() - INTERVAL '50 minutes', 24.8, 78.0, 0.0, 14.6),
('Estacao_Salvador', NOW() - INTERVAL '60 minutes', 30.0, 60.0, 0.0, 10.5),
('Estacao_Fortaleza', NOW() - INTERVAL '70 minutes', 32.2, 58.0, 0.0, 8.9),
('Estacao_Recife', NOW() - INTERVAL '80 minutes', 31.0, 63.0, 0.0, 9.0),
('Estacao_Manaus', NOW() - INTERVAL '90 minutes', 28.4, 85.0, 3.5, 5.7),
('Estacao_Brasilia', NOW() - INTERVAL '100 minutes', 27.0, 68.0, 0.0, 11.2);
