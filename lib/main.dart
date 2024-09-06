import 'dart:async';

import 'package:aa_smart_home/Services/api_service.dart';
import 'package:aa_smart_home/Views/dashboard_view.dart';
import 'package:aa_smart_home/Views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized(); //<= the key is here
    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      print("Test");
    };
    runApp(const MyApp()); // starting point of app
  }, (error, stackTrace) {
    print("async");
    throw error;
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Android Auto Smart Home',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Android Auto Smart Home'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _platform = MethodChannel('aa.smarthome/battery');
  static final _apiService = APIService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _apiService.hasExistingValidToken(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            return const DashboardView();
          }
          return const LoginView(title: "Login");
        });
  }
}
