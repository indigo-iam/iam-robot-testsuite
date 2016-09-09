# iam-robot-testsuite
A function testsuite for Indigo IAM,  based on Robot Framework and Selenium

## Synopsis
This test suite provides a bunch of tests for validate the web User Interface of Indigo IAM.

### Options
This testsuite has some customizable variables. They are the following:

| Variable     | Default value         | Meaning |
| ------------ | ----------------------| ------- |
| BROWSER      | firefox               | Browser to use for tests |
| IAM_BASE_URL | http://localhost:8080 | IAM endpoint to test |
| REMOTE_URL   | False                 | URL of Selenium Grid Hub |


## Run manually
For run the testsuite, you need Robot Framework and Selenium. Install them with:

```bash
 $ sudo yum install -y python-pip
 $ sudo pip install robotframework
 $ sudo pip install robotframework-selenium2library
```
By default, the testsuite run Selenium tests using Firefox web browser. If you want to use a different browser, you need to install
the corrisponding webdriver and put it in the library path.
For example, install Google Chrome webdriver with:

```bash
 $ wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/2.23/chromedriver_linux64.zip
 $ unzip /tmp/chromedriver.zip -d /usr/local/bin

```

Then, run the testsuite:
```bash
 $ cd iam-robot-testsuite
 $ pybot --pythonpath .:lib  -d reports/  tests/

```
You can restrict the run test specifying the sub-directory or the single file or the single test case (option _-t_).

Some useful option are:
```bash
  -d /path/to/some/dir : specify directory where write final output, log and report
  -t "Test name"       : execute only the test named with "Test name"
```

## Run with Docker
This testsuite provides a Docker image for run the tests. All the needed files are located in _docker_ folder.

First, build the new image:
```bash
 $ ./build-image.sh
```
This shell script creates a new docker image, named _italiangrid/iam-robot-testsuite_ in the local image repository.
Then run the container:

```bash
 $ docker run italiangrid/iam-robot-testsuite:latest
```
The last command launch a container that run the testsuite with default setup. For customize the execution, provide to Docker the proper environment variables with _-e_ option.
For example:

```bash
 $ docker run \ 
   -e TESTSUITE_REPO=file:///tmp/local_repo/iam-robot-testsuite \
   -e TESTSUITE_REPO=issue/issue-1 \
   -e IAM_BASE_URL=http://172.18.0.1:8080 \
   -e BROWSER=chrome \
   italiangrid/iam-testsuite:latest
```


##### Available environment variables

| Variable             | Default                                                      | Meaning |
| -------------------- | ------------------------------------------------------------ | ------- |
| TESTSUITE_REPO       | https://github.com/marcocaberletti/iam-robot-testsuite.git   | Repository hosting testsuite code |
| TESTSUITE_BRANCH     | master                                                       | Git branch to checkout |
| OUTPUT_REPORTS       | /home/tester/iam-robot-testsuite/reports                     | Directory where RobotFramework save execution report and tests outputs |
| BROWSER              | firefox                                                      | Browser to use for tests |
| IAM_BASE_URL         | http://localhost:8080                                        | IAM endpoint to test |
| REMOTE_URL           | False                                                        | URL of Selenium Grid Hub to use |


#### Setup your own Selenium Grid Hub with Docker
Bring on a Selenium Grid environment, with a hub and two nodes, one with Firefox, the other one with Google Chrome

```bash
 $ docker run -d -p "4444:4444" --name selenium-hub selenium/hub
 $ docker run -d --link selenium-hub:hub selenium/node-firefox
 $ docker run -d --link selenium-hub:hub selenium/node-chrome
```
