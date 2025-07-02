# Agentic RAG Knowledge Graph - Docker

Docker containerization of the Agentic RAG Knowledge Graph project. This repository provides a complete Docker setup for easy deployment and development of the intelligent RAG system with knowledge graph capabilities.

## Overview

This project containerizes the original [Agentic RAG Knowledge Graph](https://github.com/coleam00/ottomator-agents/tree/main/agentic-rag-knowledge-graph) project, making it easy to deploy and run in any environment with Docker support.

The system combines Retrieval-Augmented Generation (RAG) with knowledge graphs to create an intelligent document processing and question-answering system that can understand relationships between entities and provide contextual responses.

## Architecture

The Docker setup includes:

- **PostgreSQL with pgvector**: Vector database for embeddings storage
- **Neo4j**: Graph database for knowledge graph management
- **Agentic RAG Application**: Main Python application
- **Nginx**: Reverse proxy (optional, for production)

## Prerequisites

- Docker and Docker Compose installed on your system
- Git for cloning repositories
- API keys for your chosen LLM provider (OpenAI, Anthropic, etc.)

## Quick Start

### 1. Clone the Original Project

```bash
git clone https://github.com/coleam00/ottomator-agents.git
cd ottomator-agents/agentic-rag-knowledge-graph
```

### 2. Add Docker Configuration

Clone and copy the Docker configuration files:

```bash
git clone https://github.com/vcnngr/agentic-rag-knowledge-graph-docker.git docker-config
cp -r docker-config/* .
```

### 3. Environment Configuration

Copy the example environment file and configure your API keys:

```bash
cp .env.docker.example .env
```

Edit the `.env` file and add your API keys:

```env
# Essential: Add your LLM API keys
OPENAI_API_KEY=your_openai_api_key_here
ANTHROPIC_API_KEY=your_anthropic_api_key_here

# Database configurations (default values work for Docker setup)
POSTGRES_HOST=postgres
POSTGRES_PORT=5432
POSTGRES_DB=agentic_rag
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres

NEO4J_URI=bolt://neo4j:7687
NEO4J_USER=neo4j
NEO4J_PASSWORD=password
```

**Important**: The API keys for your chosen LLM provider are essential for the system to function properly.

### 4. Start the System

Build and start all services:

```bash
docker-compose up --build
```

Or run in detached mode:

```bash
docker-compose up --build -d
```

### 5. Access the Application

Once all services are running, you can access:

- **Main Application**: http://localhost:8058
- **Neo4j Browser**: http://localhost:7474 (username: neo4j, password: password)
- **PostgreSQL**: localhost:5432 (database tools)

## Docker Commands

### Essential Commands

```bash
# Start services
docker-compose up

# Start services in background
docker-compose up -d

# Build and start services
docker-compose up --build

# Stop services
docker-compose down

# Stop services and remove volumes (⚠️ deletes all data)
docker-compose down -v

# View logs
docker-compose logs

# View logs for specific service
docker-compose logs agentic-rag

# Restart a specific service
docker-compose restart agentic-rag
```

### Development Commands

```bash
# Rebuild only the main application
docker-compose build agentic-rag

# Execute commands in running container
docker-compose exec agentic-rag bash

# Check service status
docker-compose ps

# Monitor resource usage
docker stats
```

## Configuration

### Environment Variables

Key environment variables in `.env`:

| Variable | Description | Required |
|----------|-------------|----------|
| `OPENAI_API_KEY` | OpenAI API key | Yes (if using OpenAI) |
| `ANTHROPIC_API_KEY` | Anthropic API key | Yes (if using Anthropic) |
| `POSTGRES_*` | PostgreSQL connection settings | No (defaults provided) |
| `NEO4J_*` | Neo4j connection settings | No (defaults provided) |

### Volumes

The following volumes persist data:

- `postgres_data`: PostgreSQL database files
- `neo4j_data`: Neo4j graph database
- `./data`: Application data directory
- `./logs`: Application logs

## Troubleshooting

### Common Issues

1. **Port conflicts**: If ports 5432, 7474, 7687, or 8058 are already in use, modify the port mappings in `docker-compose.yml`

2. **API key errors**: Ensure your API keys are correctly set in the `.env` file

3. **Memory issues**: Neo4j and PostgreSQL require adequate memory. Increase Docker memory limits if needed

4. **Health check failures**: Wait for all services to fully start. Initial startup can take several minutes

### Viewing Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f agentic-rag
docker-compose logs -f postgres
docker-compose logs -f neo4j
```

### Database Access

```bash
# PostgreSQL
docker-compose exec postgres psql -U postgres -d agentic_rag

# Neo4j (via cypher-shell)
docker-compose exec neo4j cypher-shell -u neo4j -p password
```

## Development

For development purposes, you can:

1. Mount your local code directory as a volume
2. Use `docker-compose.override.yml` for local customizations
3. Set environment variables for development mode

## Production Deployment

For production deployment:

1. Use environment-specific `.env` files
2. Configure proper SSL certificates for Nginx
3. Set up external monitoring and logging
4. Use Docker secrets for sensitive data
5. Configure backup strategies for databases

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with Docker
5. Submit a pull request

## License

This project follows the same license as the original [Agentic RAG Knowledge Graph](https://github.com/coleam00/ottomator-agents/tree/main/agentic-rag-knowledge-graph) project.

## Support

For Docker-specific issues, please open an issue in this repository.
For questions about the core application, refer to the [original project](https://github.com/coleam00/ottomator-agents/tree/main/agentic-rag-knowledge-graph).

---

**Note**: Make sure to keep your API keys secure and never commit them to version control.