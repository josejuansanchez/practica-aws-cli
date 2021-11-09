#!/bin/bash
set -x

# Deshabilitamos la paginación de la salida de los comandos de AWS CLI
# Referencia: https://docs.aws.amazon.com/es_es/cli/latest/userguide/cliv2-migration.html#cliv2-migration-output-pager
export AWS_PAGER=""

# Obtenemos la lista de Id de las direcciones IP elásticas públicas
ELASTIC_IP_IDS=$(aws ec2 describe-addresses \
             --query Addresses[*].AllocationId \
             --output text)

# Recorremos la lista de Ids de IPs elásticas y las eliminamos
for ID in $ELASTIC_IP_IDS
do
    echo "Eliminando $ID ..."
    aws ec2 release-address --allocation-id $ID
done