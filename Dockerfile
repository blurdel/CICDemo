# Creates Docker Image for <???>

ARG targetName=CICDemo
ARG binaryName=CICDemo-0.0.1-SNAPSHOT.jar


FROM centos:7

RUN yum install -y java-11

RUN mkdir -p /opt/${targetName}           && \
    mkdir -p /opt/${targetName}/config    && \
    mkdir -p /opt/${targetName}/log

COPY ./target/${binaryName} /opt/${targetName}
COPY entrypoint.sh /opt/${targetName}
# COPY .src/main/resources/config /opt/${targetName}/config

RUN chmod +x /opt/${targetName}/entrypoint.sh

RUN useradd service_user
RUN chown service_user /opt/${targetName}

USER service_user

EXPOSE 8080

ENTRYPOINT ["/opt/${targetName}/entrypoint.sh"]
