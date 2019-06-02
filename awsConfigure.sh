#!/bin/bash

echo -e "\nGIT and AWS settings"

# CodeCommit configuration
cat <<\EOF> ~/.gitconfig
[credential]
        helper = !aws codecommit credential-helper $@
        UseHttpPath = true
EOF

# Create .gitignore
cat <<EOF> ~/.gitignore
*~
*.swp
*.swo
EOF
git config --global core.excludesfile ~/.gitignore

# Default region for aws
mkdir -p ~/.aws
cat <<\EOF> ~/.aws/config
[default]
region = eu-central-1
EOF
