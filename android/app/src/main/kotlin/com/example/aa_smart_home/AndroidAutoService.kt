package com.example.aa_smart_home

import android.content.Intent
import android.content.pm.ApplicationInfo
import androidx.car.app.CarAppService
import androidx.car.app.R
import androidx.car.app.Screen
import androidx.car.app.Session
import androidx.car.app.validation.HostValidator

class AndroidAutoService : CarAppService() {

    override fun onCreateSession(): Session {
        return HelloWorldSession()
    }

    override fun createHostValidator(): HostValidator {
        return if (applicationInfo.flags and ApplicationInfo.FLAG_DEBUGGABLE != 0) {
            HostValidator.ALLOW_ALL_HOSTS_VALIDATOR
        } else {
            HostValidator.Builder(applicationContext)
                .addAllowedHosts(R.array.hosts_allowlist_sample)
                .build()
        }
    }
}
class HelloWorldSession : Session() {
    override fun onCreateScreen(intent: Intent): Screen {
        return HelloWorldScreen(carContext)
    }
}
