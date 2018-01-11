#!/bin/bash

export MYSQL_HOST=localhost
export MYSQL_DATABASE=metastore
export MYSQL_USER_NAME=root
export MYSQL_PASSWORD=root

#Hive configurations
for template in $(ls ${HIVE_HOME}/conf/*.mustache)
do
    conf_file=${template%.mustache}
    mo ${conf_file}.mustache > ${conf_file}
done

$@