plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter Gradle Plugin (WAJIB setelah Android & Kotlin)
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

/* =====================================================
 * ANDROID CONFIG
 * ===================================================== */
android {
    namespace = "com.example.dashboard_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    /* ===== Java 17 + DESUGARING (WAJIB) ===== */
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.dashboard_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // sementara pakai debug keystore
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

/* =====================================================
 * FLUTTER SOURCE
 * ===================================================== */
flutter {
    source = "../.."
}

/* =====================================================
 * DEPENDENCIES (WAJIB UNTUK NOTIFICATION)
 * ===================================================== */
dependencies {
    // Core library desugaring (REQUIRED by flutter_local_notifications)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
