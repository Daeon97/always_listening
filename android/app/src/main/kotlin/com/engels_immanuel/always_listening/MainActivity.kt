package com.engels_immanuel.always_listening

import android.content.Intent
import android.os.Build
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler

class MainActivity : FlutterActivity() {
    private val methodChannel = "com.engels_immanuel.always_listening"
    private val methodName = "alwaysListen"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        Log.w("MainActivity", "configureFlutterEngine called")

        super.configureFlutterEngine(flutterEngine)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannel).setStreamHandler(
            object : StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    Log.w("MainActivity", "onListen called")

                    startAlwaysListeningService()
                }

                override fun onCancel(arguments: Any?) {
                    Log.w("MainActivity", "onCancel called")
                }
            }
        )
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
