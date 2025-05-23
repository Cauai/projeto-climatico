import requests
from kafka import KafkaProducer
import json
import time
from datetime import datetime
from zoneinfo import ZoneInfo  # Para fuso horário de São Paulo

API_KEY = "9554eca1ad38c35f45caaabe487f8fdc"

def create_producer():
    producer = KafkaProducer(
        bootstrap_servers=['localhost:9092'],
        value_serializer=lambda v: json.dumps(v).encode('utf-8')
    )
    return producer

def fetch_weather_data():
    url = f"https://api.openweathermap.org/data/2.5/weather?q=Sao%20Paulo&units=metric&appid={API_KEY}"
    response = requests.get(url)

    if response.status_code == 200:
        data = response.json()

        # Precipitação (chuva) nas últimas 1h, se houver
        precipitation = 0.0
        if "rain" in data and "1h" in data["rain"]:
            precipitation = data["rain"]["1h"]

        event = {
            "station_name": data["name"],
            "event_timestamp": datetime.fromtimestamp(data["dt"], tz=ZoneInfo("America/Sao_Paulo")).isoformat(),
            "temperature": data["main"]["temp"],
            "humidity": data["main"]["humidity"],
            "precipitation": precipitation,
            "wind_speed": data["wind"]["speed"]
        }

        return event
    else:
        print(f"Erro ao buscar dados: {response.status_code}")
        return None

def main():
    producer = create_producer()
    topic = 'weather'

    print("Producer iniciado. Enviando dados reais de São Paulo via OpenWeatherMap para o tópico 'weather'...")

    while True:
        event = fetch_weather_data()
        if event:
            producer.send(topic, value=event)
            print(f"[{datetime.now()}] Evento enviado:\n{json.dumps(event, indent=2)}")
        else:
            print(f"[{datetime.now()}] Nenhum evento enviado (falha na API)")

        time.sleep(300)  # A cada 5 minutos

if __name__ == "__main__":
    main()
