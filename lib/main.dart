import 'package:aa_smart_home/Services/api_service.dart';
import 'package:aa_smart_home/Services/secure_storage_service.dart';
import 'package:aa_smart_home/Views/LoginView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Android Auto Smart Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('aa.smarthome/battery');
  static final _apiService = APIService();
  static const _secureService = SecureStorageService();

  Future<void> deleteData() async {
    await _secureService.deleteSecureData("userToken");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _apiService.hasExistingValidToken(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("You are logged in.")],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: deleteData,
                child: const Text("Clear login"),
              ),
            );
          }
          return const LoginView(title: "Login");
        });
  }
}
