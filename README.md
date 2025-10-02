# Fuel

**A Flutter Version 3.35.4**

-----

Welcome to Fuel\! This document provides essential information for developers, including instructions on how to export the project's context and guidelines for maintaining the changelog.

-----

## 🏗️ Architecture and Technical Overview

This project is a Flutter application designed with a focus on clean architecture and maintainable code. Key technical choices and structural patterns include:

### 1. Architectural Pattern
The application's codebase is structured following a **BLoC (Business Logic Component) pattern**. This approach separates the user interface (UI) from the business logic, ensuring that the app's state is managed predictably and that UI components are easily testable.

### 2. State and Data Management
The project uses **BLoC** for state management, with dedicated `blocs` managing the state for different features. Data persistence is handled using two primary storage solutions based on the data's sensitivity:
- **`shared_preferences`**: Used for storing non-sensitive, lightweight data like user preferences or settings. The data is saved in a key-value format and is not encrypted.
- **`flutter_secure_storage`**: Employed for securely storing sensitive data such as API tokens, user credentials, or other confidential information. This package uses platform-specific secure storage (Keychain on iOS and Keystore on Android) to ensure data is encrypted and protected.

### 3. Build and Deployment
The application's build process is configured to support multiple environments and configurations:
- **Flavors**: The app uses `staging` and `production` flavors, which are configured to use different environment-specific variables stored in separate `.env` files.
- **Obfuscation**: For release builds, the project uses code **obfuscation** to protect intellectual property and upload debug symbols to **Sentry** for crash reporting and performance monitoring.

-----

## 🚀 Project Context Exporter (`repomix`)

This section explains how to use the `repomix` tool to generate a single, comprehensive context file of this project. This is useful for sharing, archiving, or feeding the project's structure and code to AI models.

### 1\. Prerequisites

Before you begin, ensure you have the `repomix` command-line tool installed and up-to-date. For complete installation and usage instructions, please refer to the official GitHub repository.

- **Official Documentation**: [https://github.com/yamadashy/repomix](https://github.com/yamadashy/repomix)
- **Installation**: `npm install -g repomix`

### 2\. Configuration Options

This project includes two predefined `repomix` configurations located in the `repomix_configs/` directory.

- `repomix.lib-only.json`

    - **What it does**: Exports only the core Dart code from the `lib/` directory and the `pubspec.yaml` file.
    - **Use case**: Best for a lightweight export focusing purely on the application's logic.

- `repomix.full.json`

    - **What it does**: Exports the core library code **plus** the native configuration files for both `android` and `ios`.
    - **Use case**: Ideal for a complete project export that includes native platform setups.

### 3\. How to Export

1.  Open your terminal in the root directory of this project.
2.  Choose the appropriate command below based on your needs.
3.  Replace `"path/to/your/output.md"` with your desired output file path and name.

#### Command to Export Library Code Only

```bash
repomix -o "path/to/your/project_context.md"
```

-----

## 🏃 How to Run the App

Before you run the application, ensure you have set up the environment files as described in the **"Environment Variables"** section of this Readme.

This project uses **flavors** to manage different build configurations. To run the application, you must first select the desired scheme (or flavor) in your IDE.

### In Android Studio / VS Code

1.  Look for the **"Flutter"** dropdown menu in the toolbar. It's usually located near the run button and shows the currently selected device.
2.  Next to this, you will find a dropdown for **"Flavors."** Click on it.
3.  Choose either **`staging`** or **`production`** from the list. This selects the environment for your build.
4.  Once you have selected the flavor, click the **"Run"** button to start the application with the chosen environment variables.

-----

## 🛠️ Environment Variables

This project uses **environment variables** to manage different configurations for `staging` and `production` environments. These variables are stored in dedicated files within the `keys/env/` directory.

### 1. Creating the Environment Files

You need to create two new files to store the environment variables for each build configuration.

- **`keys/env/.env-staging`**: For the staging environment.
- **`keys/env/.env-production`**: For the production environment.

You can create these files manually or by using the following commands in your terminal:

```bash
touch keys/env/.env-staging
touch keys/env/.env-production
```

### 2. Adding Variables to the Files
Once created, you must add the required variables to each file. Ensure you fill in the values for your specific environment.

**File:** `keys/env/.env-staging`
```bash
base_url = "https://api.staging.fuelapp.com"
key_tokens = "your_staging_key_tokens"
user_cache_key = "staging_user_cache"
```

**File:** `keys/env/.env-production`
```bash
base_url = "https://api.production.fuelapp.com"
key_tokens = "your_production_key_tokens"
user_cache_key = "production_user_cache"
```

**Note:** The example values provided above are placeholders. You should replace them with the actual values for your `staging` and `production` environments.

-----

## 🔧 Build Instructions for iOS and Android

- **Obfuscation:** Builds are not obfuscated by default. To enable obfuscation and upload debug symbols to Sentry, add the `--obfuscate` flag to the end of the command.

### For Android

#### Android App Bundle (AAB - Default):

- **Without Obfuscation:**
    - **Windows:** `.\scripts\build.sh [staging|production] android`
    - **Linux / macOS:** `bash scripts/build.sh [staging|production] android`
- **With Obfuscation:**
    - **Windows:** `.\scripts\build.sh [staging|production] android --obfuscate`
    - **Linux / macOS:** `bash scripts/build.sh [staging|production] android --obfuscate`

#### Android APK:

- **Without Obfuscation:**
    - **Windows:** `.\scripts\build.sh [staging|production] android apk`
    - **Linux / macOS:** `bash scripts/build.sh [staging|production] android apk`
- **With Obfuscation:**
    - **Windows:** `.\scripts\build.sh [staging|production] android apk --obfuscate`
    - **Linux / macOS:** `bash scripts/build.sh [staging|production] android apk --obfuscate`

### For iOS

**Note:** iOS release builds created with this script **must be obfuscated**. For non-obfuscated development builds, please use Xcode directly.

#### iOS IPA (Obfuscation Required):

- **Windows:** `.\scripts\build.sh [staging|production] ios --obfuscate`
- **Linux / macOS:** `bash scripts/build.sh [staging|production] ios --obfuscate`

-----

## 📝 Changelog Guidelines

### Purpose

This changelog tracks all major and minor updates to the project, ensuring transparency and accountability. **Every developer must update this file** after their merge request is approved and merged into the `main` branch.

### Rules for Updating

1.  **Add New Entries at the Top**: Place your new `Release Version` section above the most recent one. Do not modify existing entries.
2.  **Use the Correct Version**: Title the section with the current deployment version number.
3.  **Follow the Template**: Use the provided template to ensure all entries are consistent.
4.  **Be Detailed**: Clearly list all additions, updates, fixes, and removals.
5.  **Commit Your Changes**: The updated changelog must be part of your merge request.

### Entry Template

**Release Version: [Version Number]**
\---------------------------------------------------------------------------

## ChangeLog Entry

| **Date**   | **Author** | **Branch**    |
|------------|------------|---------------|
| YYYY-MM-DD | Your Name  | `branch-name` |

#### Added

- New feature or addition.

#### Updated

- Update, modification, or improvement.

#### Fixed

- Resolved bug or issue.

#### Removed

- Removed feature, code, or file.

\---------------------------------------------------------------------------