# Elasticsearch Cookbook

This repository contains training exercises and practical examples for learning Elasticsearch.

## Prerequisites

- Python 3.12 or higher
- [uv](https://github.com/astral-sh/uv) - Fast Python package manager
- Docker and Docker Compose (for running Elasticsearch cluster)

## Setup

### 1. Install uv

If you don't have `uv` installed, you can install it with:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Or using pip:

```bash
pip install uv
```

### 2. Install Dependencies

Using uv, install the project dependencies:

```bash
uv sync
```

This will create a virtual environment and install all required packages (elasticsearch and jupyterlab).

### 3. Start Elasticsearch Cluster

1. To launch one node without Kibana:

```bash
docker network create elastic
docker run --name es01 --net elastic -p 9200:9200 -e "discovery.type=single-node" -e "xpack.security.enabled=false" -it -m 1GB docker.elastic.co/elasticsearch/elasticsearch:9.2.2
```

2. Then, for Elasticsearch Cluster:

Start the Elasticsearch cluster using Docker Compose:

```bash
docker-compose up -d
```

Or for a 2-node cluster:

```bash
docker-compose -f docker-compose-2-nodes.yml up -d
```

Or for a 1-node cluster:

```bash
docker-compose -f docker-compose-1-nodes.yml up -d
```

Verify that Elasticsearch is running on `https://localhost:9200`:

```bash
curl https://localhost:9200
```

Optional: install Chrome extension **Elasticvue** (https://chromewebstore.google.com/detail/elasticvue/hkedbapjpblbodpgbajblpnlpenaebaa)

### 4. Launch JupyterLab

Start JupyterLab:

```bash
uv run jupyter lab
```

Or activate the virtual environment first:

```bash
source .venv/bin/activate  # On macOS/Linux
# or
.venv\Scripts\activate  # On Windows

jupyter lab
```

## Usage

1. Open the Jupyter notebooks in JupyterLab
2. Make sure your Elasticsearch cluster is running
3. Follow the exercises in the notebooks

The notebooks connect to Elasticsearch at `http://localhost:9200` by default.

## Stopping the Cluster

To stop the Elasticsearch cluster:

```bash
docker-compose down
```

Or for the 2-node cluster:

```bash
docker-compose -f docker-compose-2-nodes.yml down
```



