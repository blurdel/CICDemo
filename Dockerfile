FROM jenkins/jenkins:lts

USER root

RUN apt-get update \
      && apt-get install -y --force-yes sudo \
      && rm -rf /var/lib/apt/lists/*

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN groupadd -f docker
RUN usermod -a -G docker jenkins

USER jenkins

# RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt
