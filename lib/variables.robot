*** Variables ***
${IAM_BASE_URL}                  http://localhost:8080
${IAM_TEST_CLIENT_URL}           http://localhost:9090/iam-test-client
${IAM_TOKEN_ENDPOINT}            ${IAM_BASE_URL}/token
${ADMIN_USER}                    admin
${ADMIN_PASSWORD}                password
${CLIENT_ID}                     client-cred
${CLIENT_SECRET}                 secret
${TOKEN_EXCHANGE_CLIENT_ID}      token-exchange-actor
${TOKEN_EXCHANGE_CLIENT_SECRET}  secret

${BROWSER}               firefox
${SPEED}                 0.1
${REMOTE_URL}            ${EMPTY}
${TIMEOUT}               10
${DESIRED_CAPABILITIES}  ${EMPTY}
${IMPLICIT_WAIT}         1
