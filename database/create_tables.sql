CREATE TABLE IF NOT EXISTS weather_events (
    id SERIAL PRIMARY KEY,                     -- ID autoincremento único (chave primária)
    station_name VARCHAR(50),                   -- Nome da estação (texto até 50 caracteres)
    event_timestamp TIMESTAMP,                  -- Data e hora do evento de clima
    temperature FLOAT,                          -- Temperatura em graus Celsius
    humidity FLOAT,                             -- Umidade relativa do ar (em %)
    precipitation FLOAT,                        -- Precipitação em mm (chuva)
    wind_speed FLOAT,                           -- Velocidade do vento em km/h ou m/s (dependendo da fonte)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Momento da inserção no banco, preenchido automaticamente
);
