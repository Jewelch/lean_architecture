#!/bin/bash

# Find the exact path of the scripts_package
PACKAGE_PATH=$(find ~/.pub-cache/hosted/pub.dartlang.org/ -name "scripts_package*" | sort -V | tail -n 1)

# Check if the package path is found
if [ -z "$PACKAGE_PATH" ]; then
  echo "scripts_package not found in pub cache"
  exit 1
fi

# Copy the scripts folder to the Flutter project root
cp -r "$PACKAGE_PATH/scripts" ~/path_to_your_flutter_project/
