FROM docker.io/fedora:24

## Layer: base
RUN dnf install -y python-pip wget unzip git firefox

## Layer: RobotFramework
RUN pip install --upgrade pip && \
    pip install robotframework && \
    pip install robotframework-selenium2library

RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/2.23/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin
    
## Layer: tester
RUN useradd -ms /bin/bash tester
COPY files/run.sh /home/tester/
RUN chown tester:tester /home/tester/run.sh

WORKDIR /home/tester
USER tester

CMD /home/tester/run.sh
