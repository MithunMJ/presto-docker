#!/bin/bash

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

$@