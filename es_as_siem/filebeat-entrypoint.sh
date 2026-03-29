#!/bin/bash
set -e

# Copier le fichier de configuration dans un répertoire accessible en écriture
# car le volume monté est en lecture seule
CONFIG_FILE="/tmp/filebeat.yml"
cp /usr/share/filebeat/filebeat.yml "$CONFIG_FILE"

# Remplacer les variables d'environnement dans la copie de la configuration
if [ -n "$ELASTICSEARCH_PASSWORD" ]; then
  sed -i "s/\${ELASTICSEARCH_PASSWORD}/$ELASTICSEARCH_PASSWORD/g" "$CONFIG_FILE"
fi

# Attendre qu'Elasticsearch soit prêt
echo "Waiting for Elasticsearch to be ready..."
until curl -s --cacert /usr/share/filebeat/config/certs/ca/ca.crt https://es01:9200 | grep -q "missing authentication credentials"; do
  echo "Elasticsearch is not ready yet, waiting..."
  sleep 5
done

echo "Elasticsearch is ready, starting Filebeat..."

# Lancer Filebeat avec la configuration modifiée
# Dans l'image officielle Filebeat, le binaire est dans /usr/share/filebeat/filebeat
exec /usr/share/filebeat/filebeat -e -c "$CONFIG_FILE"
