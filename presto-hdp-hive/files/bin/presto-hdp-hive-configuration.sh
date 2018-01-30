#!/bin/bash

#Hadoop configurations
for template in $(ls ${HADOOP_HOME}/etc/hadoop/*.mustache)
do
    conf_file=${template%.mustache}
    mo ${conf_file}.mustache > ${conf_file}
done

#Hive configurations
for template in $(ls ${HIVE_HOME}/conf/*.mustache)
do
    conf_file=${template%.mustache}
    mo ${conf_file}.mustache > ${conf_file}
done

export NODE_ID=$(cat /proc/sys/kernel/random/uuid)

#Presto node configurations
for template in $(ls ${PRESTO_HOME}/etc/*.mustache)
do
    conf_file=${template%.mustache}
    mo ${conf_file}.mustache > ${conf_file}
done

#Catalog configurations
for template in $(ls ${PRESTO_CONF_DIR}*.mustache)
do
    conf_file=${template%.mustache}
    mo ${conf_file}.mustache > ${conf_file}
done

if [ $PRESTO_COORDINATOR = "false" ]
then
mv ${PRESTO_HOME}/etc/worker-config.properties ${PRESTO_HOME}/etc/config.properties
fi

$@

