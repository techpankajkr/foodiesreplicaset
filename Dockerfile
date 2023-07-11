FROM ubuntu:23.04
ENV JAVA_HOME=/u01/middleware/openjdk-11.0.2
ENV TOMCAT_HOME=/u01/middleware/apache-tomcat-9.0.78
ENV PATH=$PATH:${JAVA_HOME}/bin:${TOMCAT_HOME}/bin

RUN mkdir -p /u01/middleware
WORKDIR /u01/middleware

ADD  https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz .
RUN tar -xvzf openjdk-11.0.2_linux-x64_bin.tar.gz
RUN rm openjdk-11.0.2_linux-x64_bin.tar.gz

ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.78/bin/apache-tomcat-9.0.78.tar.gz .
RUN tar -xvzf apache-tomcat-9.0.78.tar.gz
RUN rm apache-tomcat-9.0.78.tar.gz

COPY target/foodies.war ${TOMCAT_HOME}/webapps
COPY run.sh /tmp
RUN chmod u+x /tmp/run.sh
ENTRYPOINT [ "/tmp/run.sh" ]
CMD [ "tail -f /dev/null" ]