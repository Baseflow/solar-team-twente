#!/bin/sh

# Fail this script if any subcommand fails.
set -e

# Function that shows usage information
usage()
{
    echo ""
    echo "Usage: $0 -c .env.prd"
    echo "  -c | --config-file        File containing the Flutter compile time configuration settings."
    echo "  -s | --secrets            File containing the Flutter secrets configuration settings."
    echo "  -h | --help               Shows this help text."
}

# Parse arguments
while [ "$1" != "" ]; do
    case $1 in
        -c | --config-file)         shift
                                    CONFIG_FILE=$1
                                    ;;
        -s | --secrets)             shift
                                    SECRETS_CONFIG_FILE=$1
                                    ;;
        -h | --help )               usage
                                    exit
                                    ;;
        * )                         usage
                                    exit 1
    esac
    shift
done

# Change working directory to the project root (from the [project]/ios/fastlane directory).
cd ../../

# Make sure we work in a clean environment.
flutter clean

# Build the generated files.
dart run build_runner build --delete-conflicting-outputs

# Build the Flutter application.
flutter build xcarchive \
    --obfuscate \
    --split-debug-info build/ios/outputs/symbols \
    --dart-define-from-file=$CONFIG_FILE \
    --dart-define-from-file=$SECRETS_CONFIG_FILE \
    --no-codesign