plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val APP_NAME = "@string/app_name"
val APP_NAME_STAGING = "@string/app_name_staging"

android {
    namespace = "com.example.fuel"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.fuel"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    flavorDimensions += "flavors"

    productFlavors {
        create("staging") {
            dimension = "flavors"
            applicationId = "za.co.cubezoo.die_biblioteek_staging"
            manifestPlaceholders["applicationLabel"] = APP_NAME_STAGING
        }
        create("production") {
            dimension = "flavors"
            applicationId = "za.co.cubezoo.die_biblioteek"
            manifestPlaceholders["applicationLabel"] = APP_NAME
        }
    }
}

flutter {
    source = "../.."
}
