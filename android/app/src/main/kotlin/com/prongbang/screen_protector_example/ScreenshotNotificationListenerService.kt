package com.prongbang.screen_protector_example

import android.content.Intent
import android.os.IBinder
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.util.Log

class ScreenshotNotificationListenerService : NotificationListenerService() {

    companion object {
        private val TAG = ScreenshotNotificationListenerService::class.java.simpleName
    }

    override fun onBind(intent: Intent?): IBinder? {
        return super.onBind(intent)
    }

    override fun onNotificationPosted(sbn: StatusBarNotification?) {

        Log.i(TAG, "onNotificationPosted: ${sbn?.notification?.extras}")

    }

    override fun onNotificationRemoved(sbn: StatusBarNotification?) {

        Log.i(TAG, "onNotificationRemoved: ${sbn?.notification?.extras}")

    }

}