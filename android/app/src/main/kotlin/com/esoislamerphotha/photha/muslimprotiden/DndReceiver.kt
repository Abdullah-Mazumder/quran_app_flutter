package com.esoislamerphotha.photha.muslimprotiden

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat

class EnableDndReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val prayer = intent.getStringExtra("prayer")!!
        val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_NONE);

//        showDndNotification(prayer, context);
    }

    private fun showDndNotification(prayer: String, context: Context) {
        val channelId = "dnd_mode_channel"
        val notificationId = 1

        // Create Notification Channel (for Android 8.0 and above)
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            val name = "DND Mode Notification"
            val descriptionText = "Notifications for Do Not Disturb mode activation"
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel(channelId, name, importance).apply {
                description = descriptionText
            }
            val notificationManager: NotificationManager =
                context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        } 

        // Build the notification
        val builder = NotificationCompat.Builder(context, channelId)
            .setSmallIcon(android.R.drawable.ic_lock_silent_mode) // Icon for the notification
            .setContentTitle("Do Not Disturb")
            .setContentText("DND mode has been activated for $prayer")
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setAutoCancel(true)

        // Show the notification
        NotificationManagerCompat.from(context).notify(notificationId, builder.build())
    }
}

class DisableDndReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_ALL);

        showDndNotification(context);
    }

    private fun showDndNotification(context: Context) {
        val channelId = "dnd_mode_channel"
        val notificationId = 1

        // Create Notification Channel (for Android 8.0 and above)
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            val name = "DND Mode Notification"
            val descriptionText = "Notifications for Do Not Disturb mode activation"
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel(channelId, name, importance).apply {
                description = descriptionText
            }
            val notificationManager: NotificationManager =
                context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }

        // Build the notification
        val builder = NotificationCompat.Builder(context, channelId)
            .setSmallIcon(android.R.drawable.ic_lock_silent_mode_off) // Icon for the notification
            .setContentTitle("Do Not Disturb")
            .setContentText("DND mode has been diactivated!")
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setAutoCancel(true)

        // Show the notification
        NotificationManagerCompat.from(context).notify(notificationId, builder.build())
    }
}
