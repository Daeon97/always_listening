package com.engels_immanuel.always_listening

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.content.pm.PackageManager
import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaRecorder
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat.getSystemService

class AlwaysListeningService : Service() {

    override fun onCreate() {
        super.onCreate()

//        showNotificationAndStartService()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.w("AlwaysListeningService", "onStartCommand called")

        startListeningAudio()
        return super.onStartCommand(intent, flags, startId)
    }

    private fun startListeningAudio() {
        Log.w("AlwaysListeningService", "startListeningAudio called")

        if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.RECORD_AUDIO
            ) == PackageManager.PERMISSION_GRANTED
        ) {
            Log.w("AlwaysListeningService", "audio permission accepted")

            showNotificationAndStartService()

            val sampleRate = 48000
            val channelConfig = AudioFormat.CHANNEL_IN_MONO
            val audioFormat = AudioFormat.ENCODING_PCM_16BIT
            val minBufferSize = AudioRecord.getMinBufferSize(sampleRate, channelConfig, audioFormat)

            val microphone =
                AudioRecord(
                    MediaRecorder.AudioSource.MIC,
                    sampleRate,
                    channelConfig,
                    audioFormat,
                    minBufferSize
                )
            microphone.startRecording()

            Log.w("AlwaysListeningService", "microphone is recording")

            val buffer = ShortArray(1024)
            Log.w("AlwaysListeningService", "immediately before while loop: buffer is $buffer")

//            while (true) {
                val readSize = microphone.read(buffer, 0, buffer.size)
                Log.w("AlwaysListeningService", "!while loop: readSize is $readSize")
//            }

//            microphone.stop()
//            microphone.release()

        }
    }

    private fun showNotificationAndStartService() {
        Log.w("AlwaysListeningService", "showNotificationAndStartService called")

        val builder = NotificationCompat.Builder(
            this@AlwaysListeningService,
            "always_listening_service_channel"
        )
            .setSmallIcon(R.drawable.launch_background)
            .setContentTitle("Listening")
            .setContentText("This app is listening on your microphone")
            .setPriority(NotificationCompat.PRIORITY_HIGH)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                "always_listening_service_channel",
                "Listening",
                NotificationManager.IMPORTANCE_HIGH
            )
            channel.description =
                "This channel notifies the user that the app is listening on their microphone"
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
            val notificationManagerCompat = NotificationManagerCompat.from(this)
            notificationManagerCompat.notify(
                1,
                builder.build()
            )
        } else {
            builder.build()
        }

        startForeground(1, builder.build())

        Log.w("AlwaysListeningService", "service created")
    }


    override fun onBind(intent: Intent?): IBinder? = null
}