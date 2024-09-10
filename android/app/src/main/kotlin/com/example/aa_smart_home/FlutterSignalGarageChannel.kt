package com.example.aa_smart_home

import android.app.Activity
import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

object FlutterSignalGarageChannel {
    private const val CHANNEL_NAME = "signal_garage"
    private lateinit var methodChannel: MethodChannel

    fun configureChannel(flutterEngine: FlutterEngine) {
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME)
    }

    fun signalGarage(appContext: Context) {
        try {
            methodChannel.invokeMethod("signalGarage", null)
        } catch (e : Exception){
            val engine = provideFlutterEngine(appContext)
            methodChannel = MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL_NAME)
            methodChannel.invokeMethod("signalGarage", null)
        }
    }

    private fun provideFlutterEngine(appContext: Context): FlutterEngine {
        val flutterEngine = FlutterEngine(appContext)
        flutterEngine
            .dartExecutor
            .executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )

        FlutterEngineCache
            .getInstance()
            .put("TempEngineID", flutterEngine)

        return flutterEngine
    }

}