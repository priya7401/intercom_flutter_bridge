import 'package:flutter/services.dart';

class IntercomService {
  static const MethodChannel _channel = MethodChannel('com.example.intercom/bridge');

  /// Initialize Intercom
  static Future<void> initializeIntercom(String apiKey, String appId) async {
    try {
      await _channel.invokeMethod('initializeIntercom', {
        'apiKey': apiKey,
        'appId': appId,
      });
    } catch (e) {
      print('Error initializing Intercom: $e');
    }
  }

  static Future<void> setUserHash(String hmac) async {
    try {
      await _channel.invokeMethod('setUserHash', {'hmac': hmac});
    } catch (e) {
      print('Error setting user hash in Intercom: $e');
    }
  }

  /// Register User with Intercom
  static Future<void> registerUser(String userId) async {
    try {
      await _channel.invokeMethod('registerUser', {'userId': userId});
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  /// Show Intercom Messenger
  static Future<void> showMessenger() async {
    try {
      await _channel.invokeMethod('showIntercomMessenger');
    } catch (e) {
      print('Error displaying Intercom Messenger: $e');
    }
  }
}
