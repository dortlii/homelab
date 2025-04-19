#!/bin/bash

VERSION="v0.31.0"

CURRENT_CONTEXT=$(kubectl config get-contexts)
printf 'using context...\n %s' "$CURRENT_CONTEXT"

curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/$VERSION/install.sh | bash -s $VERSION
