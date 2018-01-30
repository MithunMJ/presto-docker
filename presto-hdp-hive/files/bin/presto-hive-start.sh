#!/bin/bash

export PRESTO_HOME=/opt/presto

# generate unique node.id
#sed -i -e "s/__uuidgen__/$(uuidgen)/g" $PRESTO_HOME/etc/node.properties

#Run metastore service
hive --service metastore &

# Start Presto
$PRESTO_HOME/bin/launcher run
