# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Supabase
-keep class io.github.jan-tennert.supabase.** { *; }
-keep class io.ktor.** { *; }
-keep class kotlinx.serialization.** { *; }

# Firebase Crashlytics
-keep class com.google.firebase.crashlytics.** { *; }
-keep class com.google.firebase.perf.** { *; }
-dontwarn com.google.firebase.crashlytics.**
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

# Keep annotation
-keepattributes *Annotation*

# Play Core (Flutter deferred components - not used, safe to ignore)
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**

# shared_preferences (R8 missing rules)
-dontwarn io.flutter.plugins.sharedpreferences.LegacySharedPreferencesPlugin
-dontwarn io.flutter.plugins.sharedpreferences.MessagesPigeonUtils

# shared_preferences (R8 missing rules)
-dontwarn io.flutter.plugins.sharedpreferences.LegacySharedPreferencesPlugin
-dontwarn io.flutter.plugins.sharedpreferences.MessagesPigeonUtils

# shared_preferences (R8 missing rules)
-dontwarn io.flutter.plugins.sharedpreferences.LegacySharedPreferencesPlugin
-dontwarn io.flutter.plugins.sharedpreferences.MessagesPigeonUtils

# shared_preferences (R8 missing rules)
-dontwarn io.flutter.plugins.sharedpreferences.LegacySharedPreferencesPlugin
-dontwarn io.flutter.plugins.sharedpreferences.MessagesPigeonUtils
