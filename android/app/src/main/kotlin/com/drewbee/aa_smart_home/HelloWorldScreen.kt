package com.drewbee.aa_smart_home

import androidx.car.app.CarContext
import androidx.car.app.CarToast
import androidx.car.app.Screen
import androidx.car.app.model.Action
import androidx.car.app.model.CarIcon
import androidx.car.app.model.GridItem
import androidx.car.app.model.GridTemplate
import androidx.car.app.model.ItemList
import androidx.car.app.model.Template

class HelloWorldScreen(carContext: CarContext) : Screen(carContext) {

    override fun onGetTemplate(): Template {
        return landingScreen()
    }

    private fun exit() {
        carContext.finishCarApp()
    }

    private fun signalGarage() {
        FlutterSignalGarageChannel.signalGarage(carContext)
        CarToast.makeText(carContext, "Garage Triggered!", CarToast.LENGTH_SHORT).show()
    }

    private fun landingScreen() : Template {
        val listBuilder = ItemList.Builder()

        listBuilder.addItem(
            GridItem.Builder()
                .setTitle("Garage door")
                .setImage(CarIcon.APP_ICON)
                .setOnClickListener { signalGarage() }
                .build()
        )

        return GridTemplate.Builder()
            .setTitle("Android Auto Smart Home")
            .setHeaderAction(Action.APP_ICON)
            .setSingleList(listBuilder.build())
            .build()
    }
}