FROM resin/armv7hf-debian:jessie

ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_SLAVE_AGENT_PORT 50000

RUN ["cross-build-start"]

RUN apt-get update \
  && apt-get install -y --no-install-recommends curl openjdk-8-jdk \
  && rm -rf /var/lib/apt/lists/*

RUN curl -fL -o /opt/jenkins.war http://mirrors.jenkins.io/war/latest/jenkins.war

RUN ["cross-build-end"]

VOLUME ${JENKINS_HOME}

WORKDIR ${JENKINS_HOME}

EXPOSE 8080 ${JENKINS_SLAVE_AGENT_PORT}

CMD ["sh", "-c", "java -jar /opt/jenkins.war"]