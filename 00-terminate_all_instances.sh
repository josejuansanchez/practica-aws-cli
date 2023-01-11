#!/bin/bash
set -x

# Deshabilitamos la paginación de la salida de los comandos de AWS CLI
# Referencia: https://docs.aws.amazon.com/es_es/cli/latest/userguide/cliv2-migration.html#cliv2-migration-output-pager
export AWS_PAGER=""

# Obtenemos una lista con los identificadores de las instancias que están en ejecución
EC2_ID_LIST=$(aws ec2 describe-instances \
                --filters "Name=instance-state-name,Values=running" \
                --query "Reservations[*].Instances[*].InstanceId" \
                --output text)

# Eliminamos todas las intancias que están en ejecución
aws ec2 terminate-instances \
    --instance-ids $EC2_ID_LIST