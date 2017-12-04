# iam-robot-testsuite
A function testsuite for Indigo IAM,  based on Robot Framework and Selenium.

## Synopsis
This test suite provides a bunch of tests to validate the web User Interface of Indigo IAM.

### Options
This testsuite has some customizable variables. They are the following:

| Variable       | Default value         | Meaning |
| -------------- | ----------------------| ------- |
| BROWSER        | firefox               | Browser to use for tests |
| IAM_BASE_URL   | http://localhost:8080 | IAM endpoint to test |
| REMOTE_URL     | False                 | URL of Selenium Grid Hub |
| TIMEOUT        | 10                    | Time, in seconds, before after that a waiting keyword fails |
| IMPLICIT_WAIT  | 2                     | Time, in seconds, meanwhile Selenium polls the DOM trying to find an element it isn't immediately available |
| SPEED          | 0.1                   | Delay, in seconds, between two Selenium actions |
| ADMIN_USER     | admin                 | Username of IAM admin user |
| ADMIN_PASSWORD | password              | Password of IAM admin user |



## Run manually
For run the testsuite, you need Robot Framework and Selenium. Install them with:

```console
 $ sudo yum install -y python-pip
 $ sudo pip install robotframework
 $ sudo pip install selenium
 $ sudo pip install robotframework-seleniumlibrary
 $ sudo pip install robotframework-httplibrary
```

By default, the testsuite run Selenium tests using Firefox web browser. If you want to use a different browser, you need to install
the corrisponding webdriver and put it in the library path.
For example, install Google Chrome webdriver with:

```console
 $ wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/2.29/chromedriver_linux64.zip
 $ unzip /tmp/chromedriver.zip -d /usr/local/bin

 $ wget -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v0.19.1/geckodriver-v0.19.1-linux64.tar.gz
 $ cd /usr/local/bin
 $ tar zxf /tmp/geckodriver.tar.gz
```

Then, run the testsuite:
```console
 $ cd iam-robot-testsuite
 $ pybot --pythonpath .:lib  -d reports/  tests/

```

You can restrict the run test specifying the sub-directory or the single file or the single test case (option _-t_).

Some useful option are:
```console
  -d /path/to/some/dir : specify directory where write final output, log and report
  -t "Test name"       : execute only the test named with "Test name"
```

## Run with Docker and Selenium Grid
This testsuite provides a Docker image to run the tests in headless environments. 
All the needed files are located in _docker_ folder.

First, start the Selenium Grid Hub with the two node:
```console
 $ sh docker/selenium-grid/selenium_grid.sh start
```
The command above brings on a Selenium Hub, listen on TCP port 4444 ad attaches its two nodes, one with Chrome and the other with Firefox.
Verify the selenium hub status pointing a browser to `http://localhost:4444/grid/console`.

If you want connect Selenium Grid to an existing Docker network and inject an hostname into browser nodes, 
export the variables `DOCKER_NET_NAME` and `IAM_HOSTNAME`. For examples:

```console
$ IAM_HOSTNAME=iam.local.io DOCKER_NET_NAME=iam_default sh docker/selenium-grid/selenium_grid.sh start
```

Then, build the testsuite image:
```console
 $ cd docker
 $ ./build-image.sh
```
This shell script creates a new Docker image, named _italiangrid/iam-robot-testsuite_ in the local image repository.
Then run the testsuite container.

```console
 $ docker run italiangrid/iam-robot-testsuite:latest
```

The last command launch a container that run the testsuite with default setup. For customize the execution, provide to Docker the proper environment variables with _-e_ option.
For example:

```console
 $ docker run \ 
   -e TESTSUITE_REPO=file:///tmp/local_repo/iam-robot-testsuite \
   -e TESTSUITE_BRANCH=issue/issue-1 \
   -e IAM_BASE_URL=http://172.18.0.1:8080 \
   -e BROWSER=chrome \
   -e REMOTE_URL=http://selenium-hub:4444/wd/hub \
   -e TIMEOUT=30 \
   italiangrid/iam-robot-testsuite:latest
```

To run the testsuite into dockerized environment, be aware that the testsuite container can resolve both IAM instance and Selenium Hub. 
Moreover, the Selenium nodes must can resolve IAM endpoint.

##### Available environment variables

| Variable             | Default                                                      | Meaning |
| -------------------- | ------------------------------------------------------------ | ------- |
| TESTSUITE_REPO       | https://github.com/marcocaberletti/iam-robot-testsuite.git   | Repository hosting testsuite code |
| TESTSUITE_BRANCH     | master                                                       | Git branch to checkout |
| OUTPUT_REPORTS       | /home/tester/iam-robot-testsuite/reports                     | Directory where RobotFramework save execution report and tests outputs |
| BROWSER              | firefox                                                      | Browser to use for tests |
| IAM_BASE_URL         | http://localhost:8080                                        | IAM endpoint to test |
| REMOTE_URL           | False                                                        | URL of Selenium Grid Hub to use |
| TIMEOUT              | 10                                                           | Time, in seconds, after that a keyword fails |
| IMPLICIT_WAIT        | 2                                                            | Time, in seconds, meanwhile Selenium polls the DOM trying to find an element it isn't immediately available |
