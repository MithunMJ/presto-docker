#!/bin/bash

#Hive configurations
for template in $(ls ${HIVE_HOME}/conf/*.mustache)
do
    conf_file=${template%.mustache}
    mo ${conf_file}.mustache > ${conf_file}
done

$@