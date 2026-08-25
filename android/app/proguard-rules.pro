# Drift / sqlite3
-keep class com.simplemobiletools.** { *; }
-keep class io.simonbinder.** { *; }
-dontwarn org.sqlite.**

# Riverpod / generated code — no reflection used, defaults are sufficient.

# postgres / crypto
-dontwarn io.netty.**
-dontwarn org.bouncycastle.**

# local_auth
-keep class androidx.biometric.** { *; }

# home_widget
-keep class es.antonborri.home_widget.** { *; }
