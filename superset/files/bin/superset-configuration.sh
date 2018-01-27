#!/bin/bash

#Superset configurations
for template in $(ls /etc/superset/*.mustache)
do
    conf_file=${template%.mustache}
    mo ${conf_file}.mustache > ${conf_file}
done