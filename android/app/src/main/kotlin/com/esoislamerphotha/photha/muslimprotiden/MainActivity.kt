package com.esoislamerphotha.photha.muslimprotiden

import android.app.AlarmManager
import android.app.PendingIntent
import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.Calendar

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
                "enableJumaDndTask" -> {
                    val hour = call.argument<Int>("hour")!!;
                    val minute = call.argument<Int>("minute")!!;
                    val uniqueId = call.argument<String>("uniqueId")!!;
                    val prayer = call.argument<String>("prayer")!!;
                    if (notificationManager.isNotificationPolicyAccessGranted) {
                        enableJumaDndTask(hour, minute, prayer, uniqueId, result);
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
                "disableJumaDndTask" -> {
                    val hour = call.argument<Int>("hour")!!;
                    val minute = call.argument<Int>("minute")!!;
                    val uniqueId = call.argument<String>("uniqueId")!!;
                    if (notificationManager.isNotificationPolicyAccessGranted) {
                        disableJumaDndTask(hour, minute, uniqueId, result);
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
        val calendar = Calendar.getInstance().apply { timeInMillis = time }

        val intent = Intent(context, EnableDndReceiver::class.java).apply {
            action = uniqueId
            putExtra("prayer", prayer)
        }
        val requestCode = uniqueId.hashCode()
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            requestCode,
            intent,
            PendingIntent.FLAG_MUTABLE
        )
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
//        alarmManager.setInexactRepeating(AlarmManager.RTC_WAKEUP, time, AlarmManager.INTERVAL_DAY, pendingIntent);
        alarmManager.set(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, pendingIntent);

        result.success("Success.....");
    }

    private fun enableJumaDndTask(hour: Int, minute: Int, prayer: String, uniqueId: String, result: MethodChannel.Result) {
        val calendar = Calendar.getInstance().apply {
            timeInMillis = System.currentTimeMillis()
            set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY)
            set(Calendar.HOUR_OF_DAY, hour)
            set(Calendar.MINUTE, minute)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
        }
        if (calendar.timeInMillis < System.currentTimeMillis()) {
            calendar.add(Calendar.WEEK_OF_YEAR, 1)
        }

        val intent = Intent(context, EnableDndReceiver::class.java).apply {
            action = uniqueId
            putExtra("prayer", prayer)
        }
        val requestCode = uniqueId.hashCode()
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            requestCode,
            intent,
            PendingIntent.FLAG_IMMUTABLE
        )

        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        alarmManager.setInexactRepeating(
            AlarmManager.RTC_WAKEUP,
            calendar.timeInMillis,
            AlarmManager.INTERVAL_DAY * 7,
            pendingIntent
        )

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
            PendingIntent.FLAG_IMMUTABLE
        )
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        alarmManager.setInexactRepeating(AlarmManager.RTC_WAKEUP, time, AlarmManager.INTERVAL_DAY, pendingIntent);

        result.success(null);
    }

    private fun disableJumaDndTask(hour: Int, minute: Int, uniqueId: String, result: MethodChannel.Result) {
        val calendar = Calendar.getInstance().apply {
            timeInMillis = System.currentTimeMillis()
            set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY)
            set(Calendar.HOUR_OF_DAY, hour)
            set(Calendar.MINUTE, minute)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
        }
        if (calendar.timeInMillis < System.currentTimeMillis()) {
            calendar.add(Calendar.WEEK_OF_YEAR, 1)
        }

        val intent = Intent(context, DisableDndReceiver::class.java).apply {
            action = uniqueId
        }
        val requestCode = uniqueId.hashCode()
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            requestCode,
            intent,
            PendingIntent.FLAG_IMMUTABLE
        )
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        alarmManager.setInexactRepeating(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, AlarmManager.INTERVAL_DAY * 7, pendingIntent);

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
            PendingIntent.FLAG_IMMUTABLE
        )

        val intent2 = Intent(context, DisableDndReceiver::class.java).apply {
            action = uniqueId
        }
        val pendingIntent2 = PendingIntent.getBroadcast(
            context,
            requestCode,
            intent2,
            PendingIntent.FLAG_IMMUTABLE
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
