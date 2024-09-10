package com.example.aa_smart_home

import android.app.Activity
import android.view.View
import androidx.car.app.CarContext
import androidx.car.app.Screen
import androidx.car.app.model.Action
import androidx.car.app.model.CarIcon
import androidx.car.app.model.Pane
import androidx.car.app.model.PaneTemplate
import androidx.car.app.model.Row
import androidx.car.app.model.Template

class HelloWorldScreen(carContext: CarContext) : Screen(carContext) {
    override fun onGetTemplate(): Template {
        val row = Row.Builder().setTitle("Hello world!").build()
        val closeAction = Action.Builder().setTitle("Exit")
            .setIcon(CarIcon.ALERT).setOnClickListener { exit() }.build()
        val garageSignalAction = Action.Builder().setTitle("SignalGarage")
            .setOnClickListener{ signalGarage() }.build()
        val pane = Pane.Builder().addRow(row).addAction(closeAction).addAction(garageSignalAction).build()
        return PaneTemplate.Builder(pane)
            .setHeaderAction(Action.APP_ICON)
            .build()
    }

    private fun exit() {
        carContext.finishCarApp()
    }

    private fun signalGarage() {
        FlutterSignalGarageChannel.signalGarage(carContext)
    }
}