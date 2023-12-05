package com.engels_immanuel.always_listening

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.media.MediaRecorder
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat

class AlwaysListeningService : Service() {

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        startListeningAudio()
        return super.onStartCommand(intent, flags, startId)
    }

    private fun startListeningAudio() {
        val recorder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            MediaRecorder(applicationContext)
        } else {
            MediaRecorder()
        }.apply {
            setAudioSource(MediaRecorder.AudioSource.MIC)
            start()
        }
    }

    private fun showNotification() {
//        val builder = NotificationCompat.Builder(this@SaveService, Constants.SAVED_CHANNEL_ID)
//            .setSmallIcon(R.drawable.saved)
//            .setContentTitle(Constants.SAVED_NOTIFICATION_TITLE)
//            .setContentText(Constants.SAVED_NOTIFICATION_CONTENT)
//            .setColor(resources.getColor(R.color.base_app_theme_color))
//            .setPriority(NotificationCompat.PRIORITY_HIGH)

//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            val channel = NotificationChannel(Constants.SAVED_CHANNEL_ID, Constants.SAVED_CHANNEL_NAME, NotificationManager.IMPORTANCE_HIGH)
//            channel.description = Constants.SAVED_CHANNEL_DESCRIPTION
//            val manager = getSystemService(NotificationManager::class.java)
//            manager.createNotificationChannel(channel)
//            val notificationManagerCompat = NotificationManagerCompat.from(this)
//            notificationManagerCompat.notify(Constants.SAVING_SAVED_NOTIFICATION_ID, builder.build())
//        } else {
//            builder.build()
//        }
    }


    override fun onBind(intent: Intent?): IBinder? = null
}