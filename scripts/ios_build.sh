# Step 1: Increment the pubspec.yaml build number
#!/bin/bash

# Step 0: Get the directory of the current script
SCRIPT_DIR=$(dirname "$0")

# Step 1: Execute the ios_build.sh script from the same directory
"$SCRIPT_DIR/build_increment.sh"

# Step 2: Proceed with the existing build steps
cd ios
rm -Rf Podfile.lock
pod install --repo-update
cd ..
flutter build ios
