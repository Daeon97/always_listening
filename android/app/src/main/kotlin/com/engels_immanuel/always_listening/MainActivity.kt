package com.engels_immanuel.always_listening

import android.content.Intent
import android.os.Build
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val methodChannel = "com.engels_immanuel.always_listening"
    private val alwaysListenMethodName = "alwaysListen"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        Log.w("MainActivity", "configureFlutterEngine called")

        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            methodChannel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                alwaysListenMethodName -> {
                    Log.w("MainActivity", "$alwaysListenMethodName method called")

                    startAlwaysListeningService()
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun startAlwaysListeningService() {
        Log.w("MainActivity", "startAlwaysListeningService called")

        val alwaysListeningServiceIntent =
            Intent(this@MainActivity, AlwaysListeningService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(alwaysListeningServiceIntent)
        } else {
            startService(alwaysListeningServiceIntent)
        }
    }
}
