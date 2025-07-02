# Dockerfile per Agentic RAG Knowledge Graph
FROM python:3.11-slim

# Imposta le variabili d'ambiente
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive \
    PYTHONPATH=/app

# Installa le dipendenze di sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    pkg-config \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Crea directory di lavoro
WORKDIR /app

# Copia requirements first per cache optimization
COPY requirements*.txt ./

# Installa le dipendenze Python
RUN pip install --no-cache-dir --upgrade pip && \
    if [ -f requirements.txt ]; then \
        pip install --no-cache-dir -r requirements.txt; \
    else \
        echo "No requirements file found!"; \
    fi

# Copia il codice sorgente
COPY . .

# Crea le directory necessarie se non esistono
RUN mkdir -p logs data temp config && \
    chmod -R 755 logs data temp

# Esponi la porta per l'API FastAPI
EXPOSE 8058

# Comando di default
CMD ["python", "-m", "agent.api"]
