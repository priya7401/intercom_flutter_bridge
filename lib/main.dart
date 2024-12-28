import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intercom_flutter_bridge/intercom_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HelpPage(),
    );
  }
}

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  void initState() {
    super.initState();
    initializeIntercom();
  }

  Future<void> initializeIntercom() async {
    await IntercomService.initializeIntercom(
      dotenv.env[Platform.isAndroid ? 'INTERCOM_ANDROID_API_KEY' : 'INTERCOM_IOS_API_KEY'].toString(), // Replace with your API Key
      dotenv.env['INRETCOM_APP_ID'].toString(), // Replace with your App ID
    );
    await IntercomService.setUserHash(dotenv.env['INTERCOM_USER_HASH'].toString());

    await IntercomService.registerUser('1'); // Register a user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await IntercomService.showMessenger();
          },
          child: Text('Help'),
        ),
      ),
    );
  }
}