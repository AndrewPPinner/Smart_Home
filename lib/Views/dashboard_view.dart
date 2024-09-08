import 'package:aa_smart_home/Exceptions/auth_exception.dart';
import 'package:aa_smart_home/Services/api_service.dart';
import 'package:aa_smart_home/Services/secure_storage_service.dart';
import 'package:aa_smart_home/main.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  static const _secureService = SecureStorageService();
  static final _apiService = APIService();

  Future<void> deleteData() async {
    await _secureService.deleteSecureData("userToken");
    await _secureService.deleteSecureData("username");
    await _secureService.deleteSecureData("pass");
    await _secureService.deleteSecureData("userStaySignedIn");
  }

  Future<bool> signalGarage(BuildContext con) async {
    try {
      return await _apiService.signalGarage();
    } on AuthException catch (e) {
      //TODO: Make this a method callable by everyone that handles specific error types to navigate back to a certain page.
      //TODO: Custom Error type could have a Redirect property with the component to redirect to
      deleteData();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.cause)));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MyHomePage(
                  title: "Dashboard",
                )),
      );
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Home Dashboard"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await signalGarage(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(100),
                  backgroundColor: Colors.blue, // <-- Button color
                ),
                child: const Icon(
                  Icons.warehouse,
                  color: Colors.white,
                  size: 150,
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          deleteData();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(
                      title: "Dashboard",
                    )),
          );
        },
        child: const Text("Logout"),
      ),
    );
  }
}
