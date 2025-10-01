#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Default Configuration ---
OBFUSCATE=false
BUILD_FLAVOR=""
BUILD_PLATFORM=""
ANDROID_BUILD_FORMAT="appbundle" # Default Android build format

# --- Function to Display Usage Information ---
usage() {
  echo "Usage: $0 [staging|production] [android|ios] [options]"
  echo ""
  echo "This script builds the Flutter application for a specified flavor and platform."
  echo ""
  echo "Platforms & Flavors:"
  echo "  staging, production      The build flavor."
  echo "  android, ios             The target platform."
  echo ""
  echo "Options:"
  echo "  --obfuscate              Enable Dart code obfuscation."
  echo "  --apk                    (Android only) Build an APK instead of an AppBundle."
  echo "  -h, --help               Display this help message."
  echo ""
  echo "Examples:"
  echo "  ./build.sh production android --obfuscate"
  echo "  ./build.sh staging ios --obfuscate"
  echo "  ./build.sh production android --apk"
}

# --- Process Command Line Arguments ---
parse_args() {
  if [[ $# -eq 0 ]]; then
    usage
    exit 1
  fi

  BUILD_FLAVOR="$1"
  BUILD_PLATFORM="$2"
  shift 2 # Shift positional arguments to process flags

  while [[ "$#" -gt 0 ]]; do
    case "$1" in
      --obfuscate)
        OBFUSCATE=true
        shift
        ;;
      --apk)
        if [[ "$BUILD_PLATFORM" != "android" ]]; then
            echo "Error: --apk can only be used with the 'android' platform." >&2
            exit 1
        fi
        ANDROID_BUILD_FORMAT="apk"
        shift
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        echo "Error: Unknown option '$1'" >&2
        usage
        exit 1
        ;;
    esac
  done
}

# --- Main Script Logic ---
main() {
  parse_args "$@"

  # --- Configuration Variables ---
  local MAIN_DART_FILE=""
  local FLAVOR_NAME=""
  local SENTRY_ENVIRONMENT=""
  local FLUTTER_BUILD_CMD_TYPE=""
  local FLUTTER_SPLIT_DEBUG_INFO_DIR=""

  # --- Validate and Set Flavor-specific Variables ---
  case "$BUILD_FLAVOR" in
    staging)
      MAIN_DART_FILE="lib/presentation/app/flavors/main_staging.dart"
      FLAVOR_NAME="staging"
      SENTRY_ENVIRONMENT="staging"
      ;;
    production)
      MAIN_DART_FILE="lib/presentation/app/flavors/main_production.dart"
      FLAVOR_NAME="production"
      SENTRY_ENVIRONMENT="production"
      ;;
    *)
      echo "Error: Invalid build flavor '$BUILD_FLAVOR'." >&2
      usage
      exit 1
      ;;
  esac

  # --- Validate and Set Platform-specific Variables ---
  case "$BUILD_PLATFORM" in
    android)
      FLUTTER_BUILD_CMD_TYPE="$ANDROID_BUILD_FORMAT"
      FLUTTER_SPLIT_DEBUG_INFO_DIR="build/app/outputs/symbols/android/$FLAVOR_NAME"
      ;;
    ios)
      if [ "$OBFUSCATE" = false ]; then
        echo "-----------------------------------------------------------------------" >&2
        echo "Error: iOS release builds via this script must be obfuscated." >&2
        echo "Please add the --obfuscate flag." >&2
        echo "" >&2
        echo "For development builds without obfuscation, please use Xcode directly." >&2
        echo "-----------------------------------------------------------------------" >&2
        exit 1
      fi
      FLUTTER_BUILD_CMD_TYPE="ipa"
      FLUTTER_SPLIT_DEBUG_INFO_DIR="build/app/outputs/symbols/ios/$FLAVOR_NAME"
      ;;
    *)
      echo "Error: Invalid build platform '$BUILD_PLATFORM'." >&2
      usage
      exit 1
      ;;
  esac

  echo "--- Starting Flutter ${FLAVOR_NAME} ${BUILD_PLATFORM} Build (${FLUTTER_BUILD_CMD_TYPE}) ---"

  # Construct the flutter build command as an array
  local flutter_build_command=("flutter" "build" "$FLUTTER_BUILD_CMD_TYPE")
  flutter_build_command+=("-t" "$MAIN_DART_FILE")
  flutter_build_command+=("--flavor" "$FLAVOR_NAME")
  flutter_build_command+=("--release")

  if [ "$OBFUSCATE" = true ]; then
    echo "Obfuscation is ENABLED."
    flutter_build_command+=("--obfuscate")
    flutter_build_command+=("--split-debug-info=$FLUTTER_SPLIT_DEBUG_INFO_DIR")
  else
    echo "Obfuscation is DISABLED."
  fi

  # Execute the flutter build command
  echo "Executing: ${flutter_build_command[*]}"
  "${flutter_build_command[@]}"

  # --- Manual Symbol Upload Instructions ---
  if [ "$OBFUSCATE" = true ]; then
    echo ""
    echo "---------------------- MANUAL SYMBOL UPLOAD REQUIRED -----------------------"
    echo "Build successful. To deobfuscate crash reports, upload symbols."
    echo ""
    echo "1. Locate the symbol files directory at this path:"
    echo "   $FLUTTER_SPLIT_DEBUG_INFO_DIR"
    echo ""
    echo "2. Create a .zip file of that entire directory."
    echo ""
    echo "3. Navigate to Firebase Crashlytics > 'dSYMs' tab and upload the .zip file."
    echo "--------------------------------------------------------------------------"
  else
    echo "--- Build successful. Skipping Symbol Upload instructions because obfuscation was disabled. ---"
  fi

  echo "--- ${FLAVOR_NAME} ${BUILD_PLATFORM} build and symbol upload process complete! ---"
}

# --- Execute Main Function ---
main "$@"