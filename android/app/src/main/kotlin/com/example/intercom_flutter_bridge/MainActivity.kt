package com.example.intercom_flutter_bridge

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.intercom.android.sdk.Intercom
import io.intercom.android.sdk.identity.Registration

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.intercom/bridge"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "initializeIntercom" -> {
                    val apiKey = call.argument<String>("apiKey")
                    val appId = call.argument<String>("appId")

                    if (apiKey != null && appId != null) {
                        Intercom.initialize(application, apiKey, appId)
                        result.success("Intercom Initialized")
                    } else {
                        result.error("INVALID_ARGS", "API Key and App ID are required", null)
                    }
                }
                "setUserHash" -> {
                    var hmacVal = call.argument<String>("hmac")
                    
                    if (hmacVal != null) {
                        Intercom.client().setUserHash(hmacVal)

                        result.success("Intercom user hash set")
                    } else {
                        result.error("INVALID_ARGS", "hmac value is required", null)
                    }
                }
                "registerUser" -> {
                    val userId = call.argument<String>("userId")
                    if (userId != null) {
                        // Register and Login the user
                        val registration = Registration.create().withUserId(userId)
                        
                        // Login the user after registering
                        Intercom.client().loginIdentifiedUser(userRegistration = registration)
                        result.success("User logged in successfully")
                    } else {
                        result.error("INVALID_ARGS", "User ID is required", null)
                    }
                }
                "showIntercomMessenger" -> {
                    Intercom.client().displayMessenger()
                    result.success("Intercom Messenger Displayed")
                }
                else -> result.notImplemented()
            }
        }
    }
}