FROM docker.io/fedora:latest

## Layer: base
RUN dnf install -y python-pip git curl

## Layer: RobotFramework
RUN pip install --upgrade pip && \
    pip install robotframework && \
    pip install selenium==2.53.6 && \
    pip install robotframework-selenium2library

## Layer: tester
RUN useradd -ms /bin/bash tester
COPY files/run.sh /home/tester/
RUN chown tester:tester /home/tester/run.sh

WORKDIR /home/tester
USER tester

CMD /home/tester/run.sh
