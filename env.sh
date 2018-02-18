ARG=$1

if [[ -z "$AO_TOKEN_STG" ]]; then
    echo "AO_TOKEN_STG must be defined and contain a valid token"
    echo "for accessing collector-stg.appoptics.com"
elif [[ -z "$ARG" ]]; then
    echo "source this script with an argument of docker or bash"
    echo "docker defines variables for the docker environemnt testing"
    echo "bash defines variables to run at a native command prompt"
    echo
    echo "you may also use the argument debug to define additional"
    echo "debugging variables, bindings to define alternate ao-bindings"
    echo "authentication and package, or tcpdump to get help on tcpdump"
elif [[ "$ARG" = "docker" ]]; then
    export APPOPTICS_REPORTER_UDP=localhost:7832
    export APPOPTICS_TRUSTEDPATH=/appoptics/test/certs/java-collector.crt
    export APPOPTICS_COLLECTOR=java-collector:12222
    export APPOPTICS_SERVICE_KEY=${AO_TOKEN_STG}:ao-node-test-docker
    export APPOPTICS_REPORTER=udp
elif [[ "$ARG" = "bash" ]]; then
    export APPOPTICS_REPORTER_UDP=localhost:7832
    export APPOPTICS_COLLECTOR=collector-stg.appoptics.com
    export APPOPTICS_SERVICE_KEY=${AO_TOKEN_STG}:ao-node-test
    export APPOPTICS_REPORTER=udp
elif [[ "$ARG" = "debug" ]]; then
    export APPOPTICS_DEBUG_LEVEL=6
    # see src/debug-loggers.js for all the options
    export DDEBUG=appoptics:flow,appoptics:metadata,appoptics:test:message

    # Turn on the requestStore debug logging proxy (should work with fs now
    # that logging uses in memory logger if stdout or stderr are not a TTY.
    #export AO_TEST_REQUESTSTORE_PROXY=1
elif [[ "$ARG" = "bindings" ]]; then
    # use these to provide authentication and specify an alternate branch/tag
    # for the install-appoptics-bindings.js script.
    # N.B. if fetching from packagecloud setting the next two are a good
    # alternative as packagecloud's proxy doesn't have authorization issues
    # when they are installed in a project .npmrc file, not the user .npmrc
    # file.
    export AO_TEST_PACKAGE=librato/node-appoptics-bindings#per-request-v2
    # this requires that one's git access token is already defined.
    export AO_TEST_GITAUTH=${AO_TOKEN_GIT}
elif [[ "$ARG" = "tcpdump" ]]; then
    echo "try"
    echo "    $ sudo tcpdump -i lo -n udp port 7832"
    echo "to watch the UDP traffic"
    #sudo tcpdump -i lo -n udp port 7832
else
    echo "ERROR $ARG invalid"
fi

return



