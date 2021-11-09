#!/bin/bash
set -x

# Deshabilitamos la paginación de la salida de los comandos de AWS CLI
# Referencia: https://docs.aws.amazon.com/es_es/cli/latest/userguide/cliv2-migration.html#cliv2-migration-output-pager
export AWS_PAGER=""

# Guardamos una lista con todos los identificadores de las instancias EC2
SG_ID_LIST=$(aws ec2 describe-security-groups \
            --query "SecurityGroups[*].GroupId" \
            --output text)

# Recorremos la lista de ids y eliminamos las instancias
for ID in $SG_ID_LIST
do
    echo "Eliminando $ID ..."
    aws ec2 delete-security-group --group-id $ID
done