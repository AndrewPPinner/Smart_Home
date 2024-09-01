package com.example.aa_smart_home

import androidx.car.app.CarContext
import androidx.car.app.Screen
import androidx.car.app.model.Action
import androidx.car.app.model.CarIcon
import androidx.car.app.model.OnClickListener
import androidx.car.app.model.Pane
import androidx.car.app.model.PaneTemplate
import androidx.car.app.model.Row
import androidx.car.app.model.Template

class HelloWorldScreen(carContext: CarContext) : Screen(carContext) {
    override fun onGetTemplate(): Template {
        val row = Row.Builder().setTitle("Hello world!").build()
        val action = Action.Builder().setTitle("This is a button")
            .setIcon(CarIcon.ALERT).setOnClickListener { exit() }.build()
        val pane = Pane.Builder().addRow(row).addAction(action).build()
        return PaneTemplate.Builder(pane)
            .setHeaderAction(Action.APP_ICON)
            .build()
    }

    private fun exit() {
        carContext.finishCarApp()
    }
}