#! /bin/sh

# retrieves pulumi access token from the pulumi config file if it exists

# check if pulumi config file exists
if [ -f $HOME/.pulumi/credentials.json ]; then
    export PULUMI_ACCESS_TOKEN=$(cat $HOME/.pulumi/credentials.json | jq -r '.accessTokens."https://api.pulumi.com"')
fi
