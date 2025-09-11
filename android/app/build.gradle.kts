plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.yourcompany.beuty_support" // غيرت التطبيق ليكون فريد
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
        applicationId = "com.yourcompany.beuty_support" // معرف التطبيق الفريد
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        multiDexEnabled = true

        versionCode 1         // عدد صحيح فقط
        versionName "1.0.0"  // النسخة الظاهرة للمستخدم
    }

    signingConfigs {
        release {
            keyAlias 'my-key-alias'              // ضع هنا alias من keystore
            keyPassword 'key-password'           // ضع هنا كلمة المرور لل key
            storeFile file('path/to/my-release-key.jks')  // مسار keystore
            storePassword 'store-password'       // كلمة مرور keystore
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled false
            shrinkResources false
        }
    }
}

flutter {
    source = "../.."
}
