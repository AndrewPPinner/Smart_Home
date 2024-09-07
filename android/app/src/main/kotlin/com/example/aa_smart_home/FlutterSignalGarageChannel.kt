package com.example.aa_smart_home

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

object FlutterSignalGarageChannel {
    private const val CHANNEL_NAME = "signal_garage"
    private lateinit var methodChannel: MethodChannel

    fun configureChannel(flutterEngine: FlutterEngine) {
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME)
    }

    fun signalGarage() {
        methodChannel.invokeMethod("signalGarage", null)
    }
}