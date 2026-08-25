package com.hybridtracker.hybrid_tracker

import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Prevents the app's content from appearing in the Android recents
        // screenshot and blocks screen capture, per the Phase 5 privacy spec.
        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
    }
}
