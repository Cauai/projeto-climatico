from pyspark.sql import SparkSession # type: ignore
from pyspark.sql.functions import from_json, col # type: ignore
from pyspark.sql.types import StructType, StringType, DoubleType # type: ignore

# 1. Criação da SparkSession (ponto de entrada do Spark)
spark = (
    SparkSession.builder
    .appName("KafkaSparkWeatherConsumer")  # Nome da aplicação no Spark UI
    .master("local[*]")                    # Usa todos os núcleos da máquina local
    .getOrCreate()
)

# Reduz a verbosidade dos logs
spark.sparkContext.setLogLevel("WARN")

# 2. Schema esperado do JSON vindo do Kafka
schema = (
    StructType()
    .add("station_name", StringType())       # Nome da estação (ex: São Paulo)
    .add("event_timestamp", StringType())    # Data e hora do evento
    .add("temperature", DoubleType())        # Temperatura em Celsius
    .add("humidity", DoubleType())           # Umidade relativa (%)
    .add("wind_speed", DoubleType())         # Velocidade do vento (m/s)
    .add("precipitation",DoubleType())
)

# 3. Lê os dados do tópico 'weather' no Kafka
df_kafka_raw = (
    spark.readStream
    .format("kafka")
    .option("kafka.bootstrap.servers", "localhost:9092")  # Endereço do broker
    .option("subscribe", "weather")                       # Nome do tópico
    .option("startingOffsets", "latest")                  # Começa a ler os dados novos
    .load()
)

# 4. Converte o valor binário (Kafka) para JSON estruturado
df_parsed = (
    df_kafka_raw
    .selectExpr("CAST(value AS STRING) AS json_str")                 # Converte para string
    .select(from_json(col("json_str"), schema).alias("data"))        # Aplica o schema
    .select("data.*")                                                # Expande as colunas
)

# 5. Mostra os dados em tempo real no console
query = df_parsed.writeStream \
    .format("console") \
    .outputMode("append") \
    .trigger(processingTime="1 minute") \
    .start()

# 6. Mantém a aplicação rodando
query.awaitTermination()
