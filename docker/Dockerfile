FROM docker.io/fedora:latest

ARG USER_UID=10000

ENV TESTSUITE_REPO=https://github.com/indigo-iam/iam-robot-testsuite.git
ENV TESTSUITE_BRANCH=master
ENV TESTSUITE_OPTS=''
ENV OUTPUT_REPORTS=reports

ENV BROWSER=firefox
ENV IAM_BASE_URL=http://localhost:8080
ENV IAM_HTTP_HOST=iam.local.io
ENV IAM_HTTP_SCHEME=https
ENV IAM_TEST_CLIENT_URL=http://localhost:9090/iam-test-client
ENV REMOTE_URL=''
ENV TIMEOUT=10
ENV IMPLICIT_WAIT=2
ENV ADMIN_USER=admin
ENV ADMIN_PASSWORD=password
ENV CLIENT_ID=client-cred
ENV CLIENT_SECRET=secret
ENV TOKEN_EXCHANGE_CLIENT_ID=token-exchange-actor
ENV TOKEN_EXCHANGE_CLIENT_SECRET=secret


## Layer: base
RUN dnf install -y python-pip git curl ca-certificates

COPY files/igi-test-ca.pem /etc/pki/ca-trust/source/anchors/
COPY files/kube-ca.crt.pem /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust

## Layer: RobotFramework
RUN pip install --upgrade pip && \
    pip install robotframework && \
    pip install selenium==2.53.6 && \
    pip install robotframework-selenium2library && \
    pip install robotframework-httplibrary

## Layer: tester
RUN useradd -ms /bin/bash tester --uid ${USER_UID}
COPY files/run.sh /home/tester/
RUN chown tester:tester /home/tester/run.sh

WORKDIR /home/tester
USER tester

CMD /home/tester/run.sh
