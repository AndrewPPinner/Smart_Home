import 'package:aa_smart_home/Exceptions/auth_exception.dart';
import 'package:aa_smart_home/Services/api_service.dart';
import 'package:aa_smart_home/Services/secure_storage_service.dart';
import 'package:aa_smart_home/Views/config_view.dart';
import 'package:aa_smart_home/Views/popup_menu_view.dart';
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

  bool isLoading = false;

  Future<void> deleteData() async {
    await _secureService.deleteSecureData("userToken");
    await _secureService.deleteSecureData("username");
    await _secureService.deleteSecureData("pass");
    await _secureService.deleteSecureData("userStaySignedIn");
  }

  Future<bool> signalGarage(BuildContext con) async {
    try {
      setState(() {
        isLoading = true;
      });
      var res = await _apiService.signalGarage();
      setState(() {
        isLoading = false;
      });
      return res;
    } on AuthException catch (e) {
      //TODO: Make this a method callable by everyone that handles specific error types to navigate back to a certain page.
      //TODO: Custom Error type could have a Redirect property with the component to redirect to
      deleteData();
      if (con.mounted) {
        ScaffoldMessenger.of(con)
            .showSnackBar(SnackBar(content: Text(e.cause)));
        Navigator.pushReplacement(
          con,
          MaterialPageRoute(
              builder: (con) => const MyHomePage(
                    title: "Dashboard",
                  )),
        );
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Home Dashboard"),
        actions: const [PopupMenuView()],
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
                  backgroundColor: Colors.blue,
                  shadowColor: Colors.black
                ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Icon(
                        Icons.warehouse,
                        color: Colors.white,
                        size: 150,
                      ))
          ],
        ),
      )
    );
  }
}
