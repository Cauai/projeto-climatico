@echo off
echo =========================================
echo INICIANDO O PROJETO CLIMATICO COMPLETO
echo =========================================

REM ─── Ativar ambiente virtual
echo Ativando ambiente virtual...
call .\.venv\Scripts\activate

IF %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Falha ao ativar o ambiente virtual. Verifique o caminho.
    exit /b
) ELSE (
    echo Ambiente virtual ativado com sucesso.
)

REM ─── Subir containers Docker
echo Iniciando os containers com Docker Compose...
docker-compose up -d

IF %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Falha ao subir os containers. Verifique se o Docker Desktop está rodando.
    exit /b
) ELSE (
    echo Containers iniciados com sucesso.
)

REM ─── Aguardar serviços iniciarem
echo Aguardando 15 segundos para o Kafka e PostgreSQL iniciarem...
timeout /t 15 > NUL

REM ─── Iniciar o Producer em uma nova janela
echo Iniciando o Producer...
start cmd /k python producer\producer.py

IF %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Falha ao iniciar o producer.
) ELSE (
    echo Producer iniciado em nova janela.
)

REM ─── Iniciar o Spark Consumer
echo Iniciando o Spark Consumer...
set PYSPARK_PYTHON=.\.venv\Scripts\python.exe
spark-submit ^
  --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.5.0,org.postgresql:postgresql:42.7.3 ^
  spark_streamer\spark_consumer.py

IF %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Falha ao executar o Spark Consumer.
    pause
    exit /b
) ELSE (
    echo Spark Consumer finalizado.
)

pause
