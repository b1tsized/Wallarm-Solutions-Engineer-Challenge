# WAF Testing

Below I'll show my logs and basic steps performed for running the `GoTestWAF`.

# Steps

1. Followed the link to the [`GoTestWAF` docs](https://github.com/wallarm/gotestwaf?tab=readme-ov-file#configuration-options).

2. Pulled down the image to my local docker.

    ```bash
    docker pull wallarm/gotestwaf
    ```

3. Attempted to run `GoTestWAF`. It threw an error on status. I just thought it was a flag and didn't need a param, but then I read further in [documentation](https://github.com/wallarm/gotestwaf?tab=readme-ov-file#configuration-options) and realized it was asking me to pass the ignore `200`.

    ```bash
    # jturner at prometheus.attlocal.net in ~/Documents/github.com/Wallarm-Solutions-Engineer-Challenge on git:main ● [10:43:12]
    → docker run --rm --network="host" -v ${PWD}/reports:/app/reports \                                                                  <aws:b1tsized>
        wallarm/gotestwaf --url=http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com --addHeader "Host: test.b1tsized.tech" --noEmailReport
    time="2025-07-31T14:47:20Z" level=info msg="GoTestWAF started" version=v0.5.7
    time="2025-07-31T14:47:20Z" level=info msg="Test cases loading started"
    time="2025-07-31T14:47:20Z" level=info msg="Test cases loading finished"
    time="2025-07-31T14:47:20Z" level=info msg="Test cases fingerprint" fp=9a85b1a04fae92196ad6513c8aaa5995
    time="2025-07-31T14:47:20Z" level=info msg="Try to identify WAF solution"
    time="2025-07-31T14:47:20Z" level=info msg="WAF was not identified"
    time="2025-07-31T14:47:20Z" level=info msg="gohttp is used as an HTTP client to make requests" http_client=gohttp
    time="2025-07-31T14:47:20Z" level=info msg="WAF pre-check" url="http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com"
    time="2025-07-31T14:47:20Z" level=error msg="caught error in main function" error="WAF was not detected. Please use the '--blockStatusCodes' or '--blockRegex' flags. Use '--help' for additional info. Baseline attack status code: 200"

    # jturner at prometheus.attlocal.net in ~/Documents/github.com/Wallarm-Solutions-Engineer-Challenge on git:main ● [10:47:20]
    → docker run --rm --network="host" -v ${PWD}/reports:/app/reports \                                                                  <aws:b1tsized>
        wallarm/gotestwaf --url=http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com --addHeader "Host: test.b1tsized.tech" --noEmailReport --blockStatusCodes
    flag needs an argument: --blockStatusCodes
    GoTestWAF is a tool for API and OWASP attack simulation that supports a
    wide range of API protocols including REST, GraphQL, gRPC, SOAP, XMLRPC, and others.
    Homepage: https://github.com/wallarm/gotestwaf

    Usage: /app/gotestwaf [OPTIONS] --url <URL>

    Options:
        --addDebugHeader          Add header "X-GoTestWAF-Test" with a hash of the test information in each request
        --addHeader string        An HTTP header to add to requests
        --blockConnReset          If present, connection resets will be considered as block
        --blockRegex string       Regex to detect a blocking page with the same HTTP response status code as a not blocked request
        --blockStatusCodes ints   HTTP status code that WAF uses while blocking requests (default [403])
        --configPath string       Path to the config file (default "config.yaml")
        --email string            E-mail to which the report will be sent
        --followCookies           If present, use cookies sent by the server. May work only with --maxIdleConns=1 (gohttp only)
        --graphqlURL string       GraphQL URL to check
        --grpcPort uint16         gRPC port to check
        --hideArgsInReport        If present, GoTestWAF CLI arguments will not be displayed in the report
        --httpClient string       Which HTTP client use to send requests: chrome, gohttp (default "gohttp")
        --idleConnTimeout int     The maximum amount of time a keep-alive connection will live (gohttp only) (default 2)
        --ignoreUnresolved        If present, unresolved test cases will be considered as bypassed (affect score and results)
        --includePayloads         If present, payloads will be included in HTML/PDF report
        --logFormat string        Set logging format: text, json (default "text")
        --logLevel string         Logging level: panic, fatal, error, warn, info, debug, trace (default "info")
        --maxIdleConns int        The maximum number of keep-alive connections (gohttp only) (default 2)
        --maxRedirects int        The maximum number of handling redirects (gohttp only) (default 50)
        --noEmailReport           Save report locally
        --nonBlockedAsPassed      If present, count requests that weren't blocked as passed. If false, requests that don't satisfy to PassStatusCodes/PassRegExp as blocked
        --openapiFile string      Path to openAPI file
        --passRegex string        Regex to a detect normal (not blocked) web page with the same HTTP status code as a blocked request
        --passStatusCodes ints    HTTP response status code that WAF uses while passing requests (default [200,404])
        --proxy string            Proxy URL to use
        --quiet                   If present, disable verbose logging
        --randomDelay int         Random delay in ms in addition to the delay between requests (default 400)
        --renewSession            Renew cookies before each test. Should be used with --followCookies flag (gohttp only)
        --reportFormat strings    Export report in the following formats: none, json, html, pdf (default [pdf])
        --reportName string       Report file name. Supports `time' package template format (default "waf-evaluation-report-2006-January-02-15-04-05")
        --reportPath string       A directory to store reports (default "reports")
        --sendDelay int           Delay in ms between requests (default 400)
        --skipWAFBlockCheck       If present, WAF detection tests will be skipped
        --skipWAFIdentification   Skip WAF identification
        --testCase string         If set then only this test case will be run
        --testCasesPath string    Path to a folder with test cases (default "testcases")
        --testSet string          If set then only this test set's cases will be run
        --tlsVerify               If present, the received TLS certificate will be verified
        --url string              URL to check
        --version                 Show GoTestWAF version and exit
        --wafName string          Name of the WAF product (default "generic")
        --workers int             The number of workers to scan (default 5)
    flag needs an argument: --blockStatusCodes

    # jturner at prometheus.attlocal.net in ~/Documents/github.com/Wallarm-Solutions-Engineer-Challenge on git:main ● [10:48:38]
    → docker run --rm --network="host" -v ${PWD}/reports:/app/reports \                                                                  <aws:b1tsized>
        wallarm/gotestwaf --url=http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com --addHeader "Host: test.b1tsized.tech" --noEmailReport --blockStatusCodes 200
    time="2025-07-31T14:49:16Z" level=info msg="GoTestWAF started" version=v0.5.7
    time="2025-07-31T14:49:16Z" level=info msg="Test cases loading started"
    time="2025-07-31T14:49:16Z" level=info msg="Test cases loading finished"
    time="2025-07-31T14:49:16Z" level=info msg="Test cases fingerprint" fp=c6d14d6138601d19d215bb97806bcda3
    time="2025-07-31T14:49:16Z" level=info msg="Try to identify WAF solution"
    time="2025-07-31T14:49:16Z" level=info msg="WAF was not identified"
    time="2025-07-31T14:49:16Z" level=info msg="gohttp is used as an HTTP client to make requests" http_client=gohttp
    time="2025-07-31T14:49:16Z" level=info msg="WAF pre-check" url="http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com"
    time="2025-07-31T14:49:16Z" level=info msg="WAF pre-check" blocked=true code=200 status=done
    time="2025-07-31T14:49:16Z" level=info msg="gRPC pre-check" status=started
    time="2025-07-31T14:49:16Z" level=info msg="gRPC pre-check" connection="not available" status=done
    time="2025-07-31T14:49:16Z" level=info msg="GraphQL pre-check" status=started
    time="2025-07-31T14:49:16Z" level=info msg="GraphQL pre-check" connection="not available" status=done
    time="2025-07-31T14:49:16Z" level=info msg="Scanning started" url="http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com"
    Sending requests...  29% [==========>                              ] (242/822) time="2025-07-31T14:50:06Z" level=error msg="send request failed" error="sending http request: Post \"http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com\": dial tcp 3.83.183.21:80: i/o timeout"
    Sending requests...  30% [===========>                             ] (254/822) time="2025-07-31T14:50:09Z" level=error msg="send request failed" error="sending http request: Post \"http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com\": dial tcp 3.83.183.21:80: i/o timeout"
    Sending requests...  31% [===========>                             ] (262/822) time="2025-07-31T14:50:10Z" level=error msg="send request failed" error="sending http request: Post \"http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com\": dial tcp 3.83.183.21:80: i/o timeout"
    Sending requests...  38% [==============>                          ] (318/822) time="2025-07-31T14:50:40Z" level=error msg="send request failed" error="sending http request: Get \"http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com/?8b0a491bd2=I%20would%20like%20to%20request%20the%20local%20version%20of%20the%20website%20in%20French%2C%20so%20I%20will%20include%20the%20parameter%20%22hl=fr%22\": dial tcp 3.83.183.21:80: i/o timeout"
    Sending requests...  38% [==============>                          ] (319/822) time="2025-07-31T14:50:40Z" level=error msg="send request failed" error="sending http request: Post \"http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com\": dial tcp 3.83.183.21:80: i/o timeout"
    Sending requests...  39% [==============>                          ] (322/822) time="2025-07-31T14:50:41Z" level=error msg="send request failed" error="sending http request: Post \"http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com\": dial tcp 3.83.183.21:80: i/o timeout"
    Sending requests...  63% [========================>                ] (524/822) time="2025-07-31T14:51:31Z" level=error msg="send request failed" error="sending http request: Post \"http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com\": dial tcp 3.83.183.21:80: i/o timeout"
    Sending requests...  63% [========================>                ] (525/822) time="2025-07-31T14:51:31Z" level=error msg="send request failed" error="sending http request: Post \"http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com\": dial tcp 3.83.183.21:80: i/o timeout"
    Sending requests...  65% [=========================>               ] (536/822) time="2025-07-31T14:51:33Z" level=error msg="send request failed" error="sending http request: Get \"http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com/%28select%280%29from%28select%28sleep%2815%29%29%29v%29%2F%2A%27+%28select%280%29from%28select%28sleep%2815%29%29%29v%29+%27%2522+%28select%280%29from%28select%28sleep%2815%29%29%29v%29+%2522%2A%2F\": dial tcp 3.83.183.21:80: i/o timeout"
    Sending requests...  66% [==========================>              ] (549/822) time="2025-07-31T14:51:36Z" level=error msg="send request failed" error="sending http request: Post \"http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com\": dial tcp 3.83.183.21:80: i/o timeout"
    Sending requests...  70% [===========================>             ] (582/822) time="2025-07-31T14:52:05Z" level=error msg="send request failed" error="sending http request: Post \"http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com\": dial tcp 3.83.183.21:80: i/o timeout"
    Sending requests...  71% [============================>            ] (588/822) time="2025-07-31T14:52:06Z" level=error msg="send request failed" error="sending http request: Get \"http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com/?a7923b24f2=YWFhYVx1MDAyNyUyYiN7MTYqODc4N30lMmJcdTAwMjdiYmI\": dial tcp 3.83.183.21:80: i/o timeout"
    Sending requests...  72% [============================>            ] (593/822) time="2025-07-31T14:52:07Z" level=error msg="send request failed" error="sending http request: Post \"http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com\": dial tcp 3.83.183.21:80: i/o timeout"
    Sending requests...  99% [=======================================> ] (821/822) time="2025-07-31T14:52:51Z" level=error msg="send request failed" error="sending http request: Post \"http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com\": dial tcp 3.83.183.21:80: i/o timeout"
    time="2025-07-31T14:52:51Z" level=error msg="send request failed" error="sending http request: Post \"http://ac549b596e3a34ee6acbbd7550513eb5-2138899269.us-east-1.elb.amazonaws.com\": dial tcp 3.83.183.21:80: i/o timeout"
    time="2025-07-31T14:52:51Z" level=info msg="Scanning finished" duration=3m35.207021474s
    True-Positive Tests:
    ┌────────────┬───────────────────────────┬──────────────────────┬─────────────────────┬──────────────────────┬────────────────────┬─────────────┬─────────────────┐
    │  TEST SET  │         TEST CASE         │    PERCENTAGE , %    │       BLOCKED       │       BYPASSED       │     UNRESOLVED     │    SENT     │     FAILED      │
    ├────────────┼───────────────────────────┼──────────────────────┼─────────────────────┼──────────────────────┼────────────────────┼─────────────┼─────────────────┤
    │ community  │ community-128kb-rce       │ 0.00                 │ 0                   │ 0                    │ 1                  │ 1           │ 0               │
    │ community  │ community-128kb-sqli      │ 0.00                 │ 0                   │ 0                    │ 1                  │ 1           │ 0               │
    │ community  │ community-128kb-xss       │ 0.00                 │ 0                   │ 0                    │ 1                  │ 1           │ 0               │
    │ community  │ community-16kb-rce        │ 0.00                 │ 0                   │ 0                    │ 1                  │ 1           │ 0               │
    │ community  │ community-16kb-sqli       │ 0.00                 │ 0                   │ 0                    │ 1                  │ 1           │ 0               │
    │ community  │ community-16kb-xss        │ 0.00                 │ 0                   │ 0                    │ 1                  │ 1           │ 0               │
    │ community  │ community-32kb-rce        │ 0.00                 │ 0                   │ 0                    │ 1                  │ 1           │ 0               │
    │ community  │ community-32kb-sqli       │ 0.00                 │ 0                   │ 0                    │ 1                  │ 1           │ 0               │
    │ community  │ community-32kb-xss        │ 0.00                 │ 0                   │ 0                    │ 1                  │ 1           │ 0               │
    │ community  │ community-64kb-rce        │ 0.00                 │ 0                   │ 0                    │ 1                  │ 1           │ 0               │
    │ community  │ community-64kb-sqli       │ 0.00                 │ 0                   │ 0                    │ 1                  │ 1           │ 0               │
    │ community  │ community-64kb-xss        │ 0.00                 │ 0                   │ 0                    │ 1                  │ 1           │ 0               │
    │ community  │ community-8kb-rce         │ 0.00                 │ 0                   │ 0                    │ 1                  │ 1           │ 0               │
    │ community  │ community-8kb-sqli        │ 0.00                 │ 0                   │ 0                    │ 1                  │ 1           │ 0               │
    │ community  │ community-8kb-xss         │ 0.00                 │ 0                   │ 0                    │ 1                  │ 1           │ 0               │
    │ community  │ community-lfi             │ 0.00                 │ 0                   │ 0                    │ 8                  │ 8           │ 0               │
    │ community  │ community-lfi-multipart   │ 0.00                 │ 0                   │ 0                    │ 2                  │ 2           │ 0               │
    │ community  │ community-rce             │ 0.00                 │ 0                   │ 0                    │ 4                  │ 4           │ 0               │
    │ community  │ community-rce-rawrequests │ 0.00                 │ 0                   │ 0                    │ 3                  │ 3           │ 0               │
    │ community  │ community-sqli            │ 0.00                 │ 0                   │ 0                    │ 12                 │ 12          │ 0               │
    │ community  │ community-user-agent      │ 0.00                 │ 0                   │ 0                    │ 9                  │ 9           │ 0               │
    │ community  │ community-xss             │ 0.00                 │ 0                   │ 0                    │ 103                │ 104         │ 1               │
    │ community  │ community-xxe             │ 0.00                 │ 0                   │ 0                    │ 2                  │ 2           │ 0               │
    │ owasp      │ crlf                      │ 0.00                 │ 0                   │ 7                    │ 0                  │ 7           │ 0               │
    │ owasp      │ ldap-injection            │ 0.00                 │ 0                   │ 0                    │ 24                 │ 24          │ 0               │
    │ owasp      │ mail-injection            │ 0.00                 │ 0                   │ 6                    │ 18                 │ 24          │ 0               │
    │ owasp      │ nosql-injection           │ 0.00                 │ 0                   │ 10                   │ 40                 │ 50          │ 0               │
    │ owasp      │ path-traversal            │ 0.00                 │ 0                   │ 4                    │ 16                 │ 20          │ 0               │
    │ owasp      │ rce                       │ 0.00                 │ 0                   │ 0                    │ 6                  │ 6           │ 0               │
    │ owasp      │ rce-urlparam              │ 0.00                 │ 0                   │ 0                    │ 9                  │ 9           │ 0               │
    │ owasp      │ rce-urlpath               │ 0.00                 │ 0                   │ 3                    │ 0                  │ 3           │ 0               │
    │ owasp      │ shell-injection           │ 0.00                 │ 0                   │ 0                    │ 30                 │ 32          │ 2               │
    │ owasp      │ sql-injection             │ 0.00                 │ 0                   │ 7                    │ 39                 │ 48          │ 2               │
    │ owasp      │ ss-include                │ 0.00                 │ 0                   │ 6                    │ 17                 │ 24          │ 1               │
    │ owasp      │ sst-injection             │ 0.00                 │ 0                   │ 6                    │ 16                 │ 24          │ 2               │
    │ owasp      │ xml-injection             │ 0.00                 │ 0                   │ 0                    │ 7                  │ 7           │ 0               │
    │ owasp      │ xss-scripting             │ 0.00                 │ 0                   │ 55                   │ 167                │ 224         │ 2               │
    │ owasp-api  │ graphql                   │ 0.00                 │ 0                   │ 0                    │ 0                  │ 0           │ 0               │
    │ owasp-api  │ graphql-post              │ 0.00                 │ 0                   │ 0                    │ 0                  │ 0           │ 0               │
    │ owasp-api  │ grpc                      │ 0.00                 │ 0                   │ 0                    │ 0                  │ 0           │ 0               │
    │ owasp-api  │ non-crud                  │ 0.00                 │ 0                   │ 0                    │ 2                  │ 2           │ 0               │
    │ owasp-api  │ rest                      │ 0.00                 │ 0                   │ 0                    │ 7                  │ 7           │ 0               │
    │ owasp-api  │ soap                      │ 0.00                 │ 0                   │ 0                    │ 5                  │ 5           │ 0               │
    ├────────────┼───────────────────────────┼──────────────────────┼─────────────────────┼──────────────────────┼────────────────────┼─────────────┼─────────────────┤
    │      Date: │             Project Name: │ True-Positive Score: │ Blocked (Resolved): │ Bypassed (Resolved): │ Unresolved (Sent): │ Total Sent: │ Failed (Total): │
    │ 2025-07-31 │                   generic │                0.00% │       0/104 (0.00%) │    104/104 (100.00%) │   561/675 (83.11%) │         675 │  10/675 (1.48%) │
    └────────────┴───────────────────────────┴──────────────────────┴─────────────────────┴──────────────────────┴────────────────────┴─────────────┴─────────────────┘

    True-Negative Tests:
    ┌────────────┬───────────────┬──────────────────────┬─────────────────────┬──────────────────────┬────────────────────┬─────────────┬─────────────────┐
    │  TEST SET  │   TEST CASE   │    PERCENTAGE , %    │       BLOCKED       │       BYPASSED       │     UNRESOLVED     │    SENT     │     FAILED      │
    ├────────────┼───────────────┼──────────────────────┼─────────────────────┼──────────────────────┼────────────────────┼─────────────┼─────────────────┤
    │ false-pos  │ texts         │ 0.00                 │ 0                   │ 0                    │ 136                │ 141         │ 5               │
    ├────────────┼───────────────┼──────────────────────┼─────────────────────┼──────────────────────┼────────────────────┼─────────────┼─────────────────┤
    │      Date: │ Project Name: │ True-Negative Score: │ Blocked (Resolved): │ Bypassed (Resolved): │ Unresolved (Sent): │ Total Sent: │ Failed (Total): │
    │ 2025-07-31 │       generic │                0.00% │         0/0 (0.00%) │          0/0 (0.00%) │   136/141 (96.45%) │         141 │   5/141 (3.55%) │
    └────────────┴───────────────┴──────────────────────┴─────────────────────┴──────────────────────┴────────────────────┴─────────────┴─────────────────┘

    Summary:
    ┌──────────────────────┬───────────────────────────────┬──────────────────────────────┬─────────┐
    │         TYPE         │ TRUE - POSITIVE TESTS BLOCKED │ TRUE - NEGATIVE TESTS PASSED │ AVERAGE │
    ├──────────────────────┼───────────────────────────────┼──────────────────────────────┼─────────┤
    │ API Security         │ n/a                           │ n/a                          │ n/a     │
    │ Application Security │ 0.00%                         │ n/a                          │ 0.00%   │
    ├──────────────────────┼───────────────────────────────┼──────────────────────────────┼─────────┤
    │                      │                               │                        Score │   0.00% │
    └──────────────────────┴───────────────────────────────┴──────────────────────────────┴─────────┘

    2025/07/31 14:52:52 ERROR: could not unmarshal event: json: cannot unmarshal JSON string into Go network.IPAddressSpace within "/clientSecurityState/initiatorIPAddressSpace": unknown IPAddressSpace value: Local
    2025/07/31 14:52:52 ERROR: could not unmarshal event: json: cannot unmarshal JSON string into Go network.IPAddressSpace within "/clientSecurityState/initiatorIPAddressSpace": unknown IPAddressSpace value: Local
    2025/07/31 14:52:52 ERROR: could not unmarshal event: json: cannot unmarshal JSON string into Go network.IPAddressSpace within "/clientSecurityState/initiatorIPAddressSpace": unknown IPAddressSpace value: Local
    2025/07/31 14:52:52 ERROR: could not unmarshal event: json: cannot unmarshal JSON string into Go network.IPAddressSpace within "/clientSecurityState/initiatorIPAddressSpace": unknown IPAddressSpace value: Local
    time="2025-07-31T14:52:52Z" level=info msg="Export PDF full report" filename=reports/waf-evaluation-report-2025-July-31-14-52-51.pdf
    ```

4. It sucessfully ran and I've uploaded the [reports](reports/waf-evaluation-report-2025-July-31-14-52-51.pdf) to this repo.