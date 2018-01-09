# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM openjdk:8
MAINTAINER Mithun Arunan <MithunMJ@github, mithun1848@gmail.com>

# Update
RUN apt-get update && \ 
    apt-get install -y python uuid-runtime vim less jq

# Mandatory environment variables for build
ENV PRESTO_VERSION 0.184
ENV PRESTO_HOME /opt/presto
ENV PRESTO_DATA_DIR /var/presto/
ENV PRESTO_CONF_DIR $PRESTO_HOME/etc/catalog/
ENV JAVA_HOME /usr/java/default
ENV PATH $PATH:$JAVA_HOME/bin

# Download Presto
RUN curl -s -O https://repo1.maven.org/maven2/com/facebook/presto/presto-server/$PRESTO_VERSION/presto-server-$PRESTO_VERSION.tar.gz && \
    tar xvf presto-server-$PRESTO_VERSION.tar.gz

# Download Presto CLI
RUN curl -s -O https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/$PRESTO_VERSION/presto-cli-$PRESTO_VERSION-executable.jar && \
    mv presto-cli-$PRESTO_VERSION-executable.jar presto-cli && \
    chmod +x presto-cli      
    
# Create directories
RUN mkdir -p $PRESTO_HOME && \
    mkdir -p $PRESTO_DATA_DIR && \
    mkdir -p $PRESTO_HOME/etc/catalog && \
    cp -r presto-server-$PRESTO_VERSION/* $PRESTO_HOME && \
    rm -r presto-server-$PRESTO_VERSION && \
    rm presto-server-$PRESTO_VERSION.tar.gz && \
    mv presto-cli /usr/bin/

#Copy jar files for AWS S3, Azure Blob (WASB), Azure Data lake store
RUN cd $PRESTO_HOME/plugin/hive-hadoop2 && \ 
    curl -O http://repo1.maven.org/maven2/commons-lang/commons-lang/2.6/commons-lang-2.6.jar && \
    curl -O http://repo1.maven.org/maven2/org/mortbay/jetty/jetty-util/6.1.26/jetty-util-6.1.26.jar && \
    curl -O http://repo1.maven.org/maven2/com/microsoft/azure/azure-storage/2.0.0/azure-storage-2.0.0.jar && \
    curl -O http://repo1.maven.org/maven2/org/apache/hadoop/hadoop-azure/2.7.3/hadoop-azure-2.7.3.jar && \
    curl -O http://repo1.maven.org/maven2/com/microsoft/azure/azure-data-lake-store-sdk/2.1.5/azure-data-lake-store-sdk-2.1.5.jar && \
    curl -O http://repo1.maven.org/maven2/org/apache/hadoop/hadoop-azure-datalake/3.0.0-alpha3/hadoop-azure-datalake-3.0.0-alpha3.jar    

# COPY CONFIGURATION FILES
COPY ./files /opt/

#Default for presto node configuration, can be overriden at runtime
ENV PRESTO_JVM_MAX_HEAP 16G
ENV PRESTO_COORDINATOR true
ENV PRESTO_INCLUDE_COORDINATOR true
ENV PRESTO_HTTP_PORT 8080
ENV PRESTO_QUERY_MAX_MEMORY 12GB
ENV PRESTO_QUERY_MAX_MEMORY_PER_NODE 6GB
ENV PRESTO_DISCOVERY_URI http://localhost:8080
ENV PRESTO_LOG_LEVEL INFO

#Default for catalogs configuration, can be overriden at runtime
ENV HIVE_METASTORE_URI thrift://localhost:9083
ENV S3_AWS_ACCESS_KEY S3_AWS_ACCESS_KEY
ENV S3_AWS_SECRET_KEY S3_AWS_SECRET_KEY

RUN chmod +x /opt/bin/presto-configuration.sh && sleep 1 && \
    chmod +x /opt/bin/presto-start.sh && sleep 1 && \
    chmod +x /opt/bin/mo && sleep 1 && \
    mv /opt/bin/* /usr/local/bin/ && \
    mv /opt/etc/* $PRESTO_HOME/etc/ && \
    rm -r /opt/etc/

WORKDIR $PRESTO_HOME
VOLUME ["$PRESTO_DATA_DIR"]
ENTRYPOINT [ "presto-configuration.sh" ]
CMD presto-start.sh