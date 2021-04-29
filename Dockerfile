# Creates Docker Image for <???>
# docker run -d --name cicd -p 8080:8080 -p 9010:9010  cicd-demo

FROM centos:7

# Target Service folder
ENV serviceDir=Service

# Source Service binary, will be copied to "service.jar" below
ENV serviceJar=CICDemo-0.0.1-SNAPSHOT.jar


# Enable Java Remote debugging
ENV JAVA_TOOL_OPTIONS -agentlib:jdwp=transport=dt_socket,server=y,address=0.0.0.0:9010,suspend=n

RUN yum install -y java-11

RUN mkdir -p /opt/${serviceDir}           && \
    mkdir -p /opt/${serviceDir}/config    && \
    mkdir -p /opt/${serviceDir}/log

COPY ./target/${serviceJar} /opt/${serviceDir}/service.jar

# COPY entrypoint.sh          /opt/${serviceDir}
# RUN chmod +x /opt/${serviceDir}/entrypoint.sh

RUN useradd service_user
RUN chown service_user /opt/${serviceDir}

USER service_user

# Java remote debug port (same as above)
EXPOSE 9010

# Application port
EXPOSE 8080

WORKDIR /opt/${serviceDir} 

# ENTRYPOINT ["/opt/Service/entrypoint.sh"]
ENTRYPOINT ["java", "-jar", "service.jar"]
