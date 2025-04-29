# Projeto de Streaming de Dados Climáticos 🌦️

Este projeto simula o envio de dados meteorológicos em tempo real usando Apache Kafka, Python e PostgreSQL, tudo orquestrado com Docker Compose.

---

## 🛠️ Tecnologias utilizadas

- **Python 3.10+**
- **Apache Kafka**
- **PostgreSQL**
- **Docker + Docker Compose**
- **Kafka-Python** (producer e consumer)
- **psycopg2-binary** (conexão PostgreSQL)

---

## 🚀 Como executar o projeto

### 1. Clonar o repositório

```bash
git clone https://github.com/seu-usuario/projeto-climatico.git
cd projeto-climatico
```

### 2. Subir os serviços com Docker Compose

```bash
docker-compose up -d
```

Este comando irá iniciar:
- Zookeeper
- Kafka Broker
- PostgreSQL (Banco `weather_db`)

O PostgreSQL já será inicializado com a tabela `weather_events`.

---

### 3. Criar e ativar o ambiente virtual no VSCode

```bash
# Criar o ambiente
python -m venv .venv

# Ativar no Windows PowerShell
.\.venv\Scripts\Activate.ps1
```

Você verá seu terminal assim:
```
(.venv) C:\Users\SeuUsuario\projeto-climatico>
```

---

### 4. Instalar as dependências Python

```bash
pip install kafka-python psycopg2-binary
```

Opcionalmente, gerar o arquivo de dependências:

```bash
pip freeze > requirements.txt
```

---

### 5. Rodar o Producer (envio de dados climáticos para o Kafka)

```bash
python producer/producer.py
```

O `producer.py` irá:
- Gerar dados sintéticos de clima
- Enviar eventos para o tópico Kafka chamado `weather` a cada 5 segundos

Exemplo de mensagem enviada:
```json
{
  "station_name": "Estacao_Sao_Paulo",
  "event_timestamp": "2025-04-28T21:00:12.345678",
  "temperature": 26.5,
  "humidity": 70.0,
  "precipitation": 0.0,
  "wind_speed": 15.2
}
```

---

### 6. Rodar o Consumer (opcional - em construção)

O consumer irá:
- Ler os eventos do Kafka
- Inserir os dados automaticamente no banco `weather_db` na tabela `weather_events`

(Em breve...)

---

## 📂 Estrutura do projeto

```bash
projeto-climatico/
│
├── docker-compose.yml
├── database/
│   └── create_tables.sql
├── producer/
│   └── producer.py
├── consumer/          # (a ser criado)
│   └── consumer.py
├── .venv/             # Ambiente virtual
├── requirements.txt
└── README.md
```

---

## 📋 Observações

- A tabela `weather_events` é criada automaticamente na primeira subida do container PostgreSQL.
- Certifique-se de que o ambiente virtual `.venv` esteja ativado antes de rodar os scripts Python.
- No DBeaver, desative o SSL para conectar ao banco PostgreSQL local.
- Kafka e Zookeeper devem estar rodando para que o Producer e Consumer funcionem corretamente.

---

## 🔥 Próximos passos

- Criar o `consumer.py` para integrar o Kafka ao PostgreSQL.
- Implementar monitoramento básico dos fluxos.
- (Opcional) Dockerizar a aplicação Python para rodar Producer/Consumer em containers também.

---