FROM ubuntu:14.04

MAINTAINER Pavel Larkin "laxkin@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

### Install base files

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget nano zip && \
  rm -rf /var/lib/apt/lists/*

### Install Java.

RUN \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk7-installer

### Maven

RUN wget --progress=bar:force http://mirror.reverse.net/pub/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz -P /tmp/ && \
    tar xvfz /tmp/apache-maven-3.3.3-bin.tar.gz --directory /opt && \
    rm -f /tmp/apache-maven-3.3.3-bin.tar.gz && \
    update-alternatives --install /usr/bin/mvn mvn /opt/apache-maven-3.3.3/bin/mvn 1 && \
    mkdir -p /root/.m2
ENV M2_HOME /opt/apache-maven-3.3.3

### Jenkins

ADD http://mirrors.jenkins-ci.org/war/1.617/jenkins.war /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /jenkins
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV TERM xterm

ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"]

EXPOSE 8080

CMD [""]
