package com.hybridtracker.hybrid_tracker

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

/**
 * Shows today's water intake. Tapping the amount opens the app to the
 * Wellness screen; tapping "+" logs 250ml in the background via
 * HomeWidgetBackgroundIntent, which runs `_addWaterInBackground` in a
 * headless Flutter engine (registered in main.dart) — no app UI shown.
 */
class WaterTrackerWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val consumed = widgetData.getString("waterConsumedMl", "0") ?: "0"
            val goal = widgetData.getString("waterGoalMl", "2000") ?: "2000"
            val views = RemoteViews(context.packageName, R.layout.water_tracker_widget).apply {
                setTextViewText(R.id.water_widget_amount, "$consumed / $goal ml")
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                    context, MainActivity::class.java, Uri.parse("ryve://wellness")
                )
                setOnClickPendingIntent(R.id.water_widget_container, pendingIntent)

                val addPendingIntent = HomeWidgetBackgroundIntent.getBroadcast(
                    context, Uri.parse("ryve://widget/water/add")
                )
                setOnClickPendingIntent(R.id.water_widget_add_button, addPendingIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
