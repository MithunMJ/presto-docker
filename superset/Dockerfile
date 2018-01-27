FROM amancevice/superset:0.19.1

USER root

RUN apt-get update
RUN apt-get -y install vim less jq
RUN apt-get -y install  nfs-common

COPY ./files /_build

RUN chmod +x /_build/bin/* && \
	mv /_build/bin/* /usr/local/bin/

RUN mv /_build/config/* /etc/superset

EXPOSE 8088

ENTRYPOINT ["superset-configuration.sh"]
CMD ["superset", "runserver"]

USER superset