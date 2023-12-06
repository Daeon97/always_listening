package com.engels_immanuel.always_listening

import android.Manifest
import android.annotation.SuppressLint
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.content.pm.PackageManager
import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaRecorder
import android.os.Build
import android.os.CountDownTimer
import android.os.IBinder
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import java.io.File

class AlwaysListeningService : Service() {
    private val serviceNotificationId = 1
    private val serviceNotificationChannelId = "always_listening_service_channel"
    private val serviceNotificationContentTitle = "Listening"
    private val serviceNotificationContentText = "This app is listening to your microphone"
    private val serviceNotificationChannelName = "Listening"
    private val serviceNotificationChannelDescription =
        "This channel notifies the user that the app is listening to their microphone"

    override fun onCreate() {
        super.onCreate()
        startForeground(
            serviceNotificationId, buildNotification(
                channelId = serviceNotificationChannelId,
                contentTitle = serviceNotificationContentTitle,
                contentText = serviceNotificationContentText,
                channelName = serviceNotificationChannelName,
                channelDescription = serviceNotificationChannelDescription,
                notificationId = serviceNotificationId
            )
        )
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        startForeground(
            serviceNotificationId, buildNotification(
                channelId = serviceNotificationChannelId,
                contentTitle = serviceNotificationContentTitle,
                contentText = serviceNotificationContentText,
                channelName = serviceNotificationChannelName,
                channelDescription = serviceNotificationChannelDescription,
                notificationId = serviceNotificationId
            )
        )
        startAudio()
        return super.onStartCommand(intent, flags, startId)
    }

    private fun startAudio() {
        Log.w("startAudio", "startAudio called")

        if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.RECORD_AUDIO
            ) == PackageManager.PERMISSION_GRANTED
        ) {
            Log.w("startAudio", "audio permission accepted")
            recordAudio()
        }
    }

    @SuppressLint("NewApi")
    private fun recordAudio() {
        Log.w("recordAudio", "startAudio called")

        val file = File(getExternalFilesDir(null), "Audio.mp4")
        if (file.exists()) file.delete()

        Log.w("path", file.toString())

        val recorder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            MediaRecorder(applicationContext)
        } else {
            MediaRecorder()
        }.apply {
            setAudioSource(MediaRecorder.AudioSource.MIC)
            setOutputFormat(MediaRecorder.OutputFormat.MPEG_4)
            setAudioEncoder(MediaRecorder.AudioEncoder.AMR_NB)
            setOutputFile(file)
            prepare()
            start()
        }

        Log.w("recordAudio", "recorder object created")

        val timer = object : CountDownTimer(6000, 1000) {
            override fun onTick(p0: Long) {
                Log.w("recordAudio", "timer ticked")
            }

            override fun onFinish() {
                recorder.stop()
                recorder.reset()
                recorder.release()

                Log.w("recordAudio", "timer finished, recorder object disposed")

                buildNotification(
                    channelId = "audio_saved_channel",
                    contentTitle = "Audio Saved",
                    contentText = "Audio captured from your mic was saved",
                    channelName = "Audio Saved",
                    channelDescription = "This channel notifies the user that audio was saved",
                    notificationId = 2
                )
            }
        }

        Log.w("recordAudio", "timer object created")

        timer.start()

        Log.w("recordAudio", "timer started")
    }

    @SuppressLint("MissingPermission")
    // Do not call this on the main thread
    private fun openAudioStream() {
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

        Log.w("openAudioStream", "microphone is recording")

        val buffer = ShortArray(1024)
        Log.w("openAudioStream", "immediately before while loop: buffer is $buffer")

        while (true) {
            val readSize = microphone.read(buffer, 0, buffer.size)
            Log.w("openAudioStream", "!while loop: readSize is $readSize")
        }

//            microphone.stop()
//            microphone.release()
    }

    private fun buildNotification(
        channelId: String,
        contentTitle: String,
        contentText: String,
        channelName: String,
        channelDescription: String,
        notificationId: Int,
    ): Notification {
        val builder = NotificationCompat.Builder(
            this@AlwaysListeningService,
            channelId
        )
            .setSmallIcon(R.drawable.launch_background)
            .setContentTitle(contentTitle)
            .setContentText(contentText)
            .setPriority(NotificationCompat.PRIORITY_HIGH)

        val build = builder.build()

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                channelId,
                channelName,
                NotificationManager.IMPORTANCE_HIGH
            )
            channel.description =
                channelDescription
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
            val notificationManagerCompat = NotificationManagerCompat.from(this)
            notificationManagerCompat.notify(
                notificationId,
                build
            )
        } else {
            build
        }

        return build
    }


    override fun onBind(intent: Intent?): IBinder? = null
}