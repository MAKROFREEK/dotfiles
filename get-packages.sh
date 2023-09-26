#!/bin/bash

#!/bin/bash

while read -r package; do
echo "Downloading package: $package"
# Replace the following line with the appropriate package manager command for your system
# For example, if you're using apt-get on Ubuntu, you would use: apt-get install -y "$package"
# For yum on CentOS, you would use: yum install -y "$package"
# Modify the command as needed for your package manager
yay -S "$package"
done < packages-list