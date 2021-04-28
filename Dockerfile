# Creates Docker Image for <???>

#FROM nimmis/java-centos:openjdk-11-jdk
FROM centos:7

RUN yum install -y java-11

RUN mkdir -p /opt/MyService           && \
    mkdir -p /opt/MyService/config    && \
    mkdir -p /opt/MyService/log

COPY ./target/CICDemo-0.0.1-SNAPSHOT.jar /opt/MyService
#COPY .src/main/resources/config /opt/MyService/config
#COPY .src/main/resources/config /opt/MyService/config

COPY entrypoint.sh /opt/MyService

RUN chmod +x /opt/MyService/entrypoint.sh

RUN useradd service_user
RUN chown service_user /opt/MyService

# USER docker
USER service_user
EXPOSE 8080

ENTRYPOINT ["/opt/MyService/entrypoint.sh"]

