package com.engels_immanuel.always_listening

import android.content.Intent
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val methodChannel = "com.engels_immanuel.always_listening"
    private val methodName = "alwaysListen"


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            methodChannel
        ).setMethodCallHandler { call, result ->
            if (call.method == methodName) {
                startAlwaysListeningService()
                result.success("Always listening service was started")
            } else {
                result.notImplemented()
            }
        }
    }

    private fun startAlwaysListeningService() {
        val alwaysListeningServiceIntent =
            Intent(this@MainActivity, AlwaysListeningService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(alwaysListeningServiceIntent)
        } else {
            startService(alwaysListeningServiceIntent)
        }
    }
}
