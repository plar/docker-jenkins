FROM ubuntu:14.04

MAINTAINER Pavel Larkin "laxkin@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

### Install base files

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget nano zip && \
  apt-get install -y python2.7-dev && \
  apt-get install -y python-pip && \
  apt-get clean autoclean && \
  apt-get autoremove -y  && \
  rm -rf /var/lib/{apt,dpkg,cache,log}

# Install PhantomJS for headless and it's dependencies.
RUN \
  curl -sL https://deb.nodesource.com/setup | bash - && \
  apt-get install -y nodejs fontconfig && \
  npm install -g phantomjs && \
  apt-get clean autoclean && \
  apt-get autoremove -y  && \
  rm -rf /var/lib/{apt,dpkg,cache,log}

### Install AWS tools
RUN pip install awscli

### Install Java.
RUN \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer && \
  rm -rf /var/cache/oracle-jdk7-installer

### Maven
RUN \
  wget --progress=bar:force http://mirror.reverse.net/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz -P /tmp/ && \
  tar xvfz /tmp/apache-maven-3.3.9-bin.tar.gz --directory /opt && \
  rm -f /tmp/apache-maven-3.3.9-bin.tar.gz && \
  update-alternatives --install /usr/bin/mvn mvn /opt/apache-maven-3.3.9/bin/mvn 1 && \
  mkdir -p /root/.m2

### Jenkins
RUN \
  wget --progress=bar:force http://mirrors.jenkins-ci.org/war-stable/1.651.3/jenkins.war -P /opt/ && \
  chmod 644 /opt/jenkins.war

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV M2_HOME /opt/apache-maven-3.3.9
ENV JENKINS_HOME /jenkins
ENV TERM xterm

ENTRYPOINT ["sh", "-c", "java $JAVA_ARGS -jar /opt/jenkins.war"]

EXPOSE 8080

CMD [""]
