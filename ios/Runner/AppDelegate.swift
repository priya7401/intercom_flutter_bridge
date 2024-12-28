import UIKit
import Flutter
import Intercom

@main
@objc class AppDelegate: FlutterAppDelegate {

  private let CHANNEL = "com.example.intercom/bridge"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    super.application(application, didFinishLaunchingWithOptions: launchOptions)

    // Register the method channel
    let controller = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

    methodChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      switch call.method {
        case "setUserHash":
            if let hmac = call.arguments as? [String: Any], let hmacValue = hmac["hmac"] as? String {
              // Set User Hash for Intercom
              Intercom.setUserHash(hmacValue)
              result("Intercom user hash set")
            } else {
              result(FlutterError(code: "INVALID_ARGS", message: "HMAC value is required", details: nil))
            }
        case "initializeIntercom":
            if let arguments = call.arguments as? [String: Any],
              let apiKey = arguments["apiKey"] as? String,
              let appId = arguments["appId"] as? String {
              // Initialize Intercom
              Intercom.setApiKey(apiKey, forAppId: appId)
              result("Intercom Initialized")
            } else {
              result(FlutterError(code: "INVALID_ARGS", message: "API Key and App ID are required", details: nil))
            }
        case "registerUser":
            if let arguments = call.arguments as? [String: Any], let userId = arguments["userId"] as? String {
                // Register and login the user
                // let registration = Registration.create().withUserId(userId)
              let attributes = ICMUserAttributes()
              attributes.userId = userId // Assign the userId from Flutter method channel

              // Log the user in using the Intercom SDK
              Intercom.loginUser(with: attributes) 
              result("User logged in successfully")
            } else {
              result(FlutterError(code: "INVALID_ARGS", message: "User ID is required", details: nil))
            }
        case "showIntercomMessenger":
          // Show the Intercom Messenger
          Intercom.present()
          result("Intercom Messenger Displayed")
        default:
          result(FlutterMethodNotImplemented)
        }
      }
      return true
  }
}
