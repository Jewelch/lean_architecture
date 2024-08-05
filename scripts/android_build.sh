#!/bin/bash

# Step 0: Get the directory of the current script
SCRIPT_DIR=$(dirname "$0")

# Step 1: Remove the build folder, Symbols.zip file, and release_build folder
rm -rf "$SCRIPT_DIR/../build"
rm -f "$SCRIPT_DIR/../Symbols.zip"
rm -rf "$SCRIPT_DIR/../release_build"

# Step 2: Execute the build_increment.sh script from the same directory
"$SCRIPT_DIR/build_increment.sh"

# Step 3: Build the Flutter APK with obfuscation and split debug info
flutter build apk --release --obfuscate --split-debug-info="$SCRIPT_DIR/../release_build"

# Step 4: Navigate to the folder containing the merged native libraries
cd build/app/intermediates/merged_native_libs/release/out/lib || exit

# Step 5: Compress all 3 folders into a single zip file named "Symbols.zip"
zip -r Symbols.zip ./*

# Step 6: Remove any "__MACOSX" directories from the zip file
zip -d Symbols.zip "__MACOSX*"

# Step 7: Move the resulting "Symbols.zip" file to the main app folder
mv Symbols.zip ../../../../../../../../Symbols.zip

echo "Process completed. Symbols.zip is now located next to your pubspec.yaml file."
