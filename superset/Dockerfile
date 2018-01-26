FROM amancevice/superset:0.19.1

USER root

RUN apt-get update
RUN apt-get -y install vim less jq
RUN apt-get -y install  nfs-common

EXPOSE 8088

USER superset

