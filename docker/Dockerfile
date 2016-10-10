FROM docker.io/centos:7

## Layer: base
RUN yum install -y epel-release && \
    yum clean all && \
    yum makecache
RUN yum install -y python-pip git

## Layer: RobotFramework
RUN pip install --upgrade pip && \
    pip install robotframework && \
    pip install robotframework-selenium2library

## Layer: tester
RUN useradd -ms /bin/bash tester
COPY files/run.sh /home/tester/
RUN chown tester:tester /home/tester/run.sh

WORKDIR /home/tester
USER tester

CMD /home/tester/run.sh
