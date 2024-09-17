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
import androidx.core.graphics.drawable.IconCompat

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
        val garageIcon = CarIcon.Builder(IconCompat.createWithResource(carContext, R.drawable.ic_garage_icon)).build()

        listBuilder.addItem(
            GridItem.Builder()
                .setTitle("Garage door")
                .setImage(garageIcon)
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