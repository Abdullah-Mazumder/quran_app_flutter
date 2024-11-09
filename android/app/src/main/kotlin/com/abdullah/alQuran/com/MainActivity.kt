package com.abdullah.alQuran.com

import android.app.AlarmManager
import android.app.PendingIntent
import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private  val channel = "com.abdullah.alQuran.com";

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            when (call.method) {
                "enableDndTask" -> {
                    val startTime = call.argument<Long>("startTime")!!;
                    val uniqueId = call.argument<String>("uniqueId")!!;
                    val prayer = call.argument<String>("prayer")!!;
                    if (notificationManager.isNotificationPolicyAccessGranted) {
                        enableDndTask(startTime, prayer, uniqueId, result);
                    } else {
                        requestDndPermission();
                    }
                }
                "disableDndTask" -> {
                    val endTime = call.argument<Long>("endTime")!!;
                    val uniqueId = call.argument<String>("uniqueId")!!;
                    if (notificationManager.isNotificationPolicyAccessGranted) {
                        disableDndTask(endTime, uniqueId, result);
                    } else {
                        requestDndPermission();
                    }
                }
                "stopTask" -> {
                    val uniqueId = call.argument<String>("uniqueId")!!;
                    cancelTask(uniqueId, result);
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun enableDndTask(time: Long, prayer: String, uniqueId: String, result: MethodChannel.Result) {
        val intent = Intent(context, EnableDndReceiver::class.java).apply {
            action = uniqueId
            putExtra("prayer", prayer)
        }
        val requestCode = uniqueId.hashCode()
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            requestCode,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT
        )
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        alarmManager.setInexactRepeating(AlarmManager.RTC_WAKEUP, time, AlarmManager.INTERVAL_DAY, pendingIntent);

        result.success(null);
    }

    private fun disableDndTask(time: Long, uniqueId: String, result: MethodChannel.Result) {
        val intent = Intent(context, DisableDndReceiver::class.java).apply {
            action = uniqueId
        }
        val requestCode = uniqueId.hashCode()
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            requestCode,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT
        )
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        alarmManager.setInexactRepeating(AlarmManager.RTC_WAKEUP, time, AlarmManager.INTERVAL_DAY, pendingIntent);

        result.success(null);
    }

    private fun cancelTask(uniqueId: String, result: MethodChannel.Result) {
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent1 = Intent(context, EnableDndReceiver::class.java).apply {
            action = uniqueId
        }
        val requestCode = uniqueId.hashCode()
        val pendingIntent1 = PendingIntent.getBroadcast(
            context,
            requestCode,
            intent1,
            PendingIntent.FLAG_UPDATE_CURRENT
        )

        val intent2 = Intent(context, DisableDndReceiver::class.java).apply {
            action = uniqueId
        }
        val pendingIntent2 = PendingIntent.getBroadcast(
            context,
            requestCode,
            intent2,
            PendingIntent.FLAG_UPDATE_CURRENT
        )

        alarmManager.cancel(pendingIntent1);
        alarmManager.cancel(pendingIntent2);

        result.success(null);
    }

    private fun requestDndPermission() {
        val intent = Intent(android.provider.Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS)
        startActivity(intent)
    }

}