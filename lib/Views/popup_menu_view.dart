import 'package:aa_smart_home/Services/secure_storage_service.dart';
import 'package:aa_smart_home/Views/config_view.dart';
import 'package:aa_smart_home/main.dart';
import 'package:flutter/material.dart';

class PopupMenuView extends StatefulWidget {
  const PopupMenuView({super.key});

  @override
  State<PopupMenuView> createState() => _PopupMenuViewState();
}

class _PopupMenuViewState extends State<PopupMenuView> {
  static const _secureService = SecureStorageService();

  Future<void> deleteData() async {
    await _secureService.deleteSecureData("userToken");
    await _secureService.deleteSecureData("username");
    await _secureService.deleteSecureData("pass");
    await _secureService.deleteSecureData("userStaySignedIn");
  }

  void menuSelect(String value) async {
    switch (value) {
      case "Settings":
      Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ConfigView())
          );
      case "Logout":
          deleteData();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(
                      title: "Dashboard",
                    )),
          );
    }

  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              value: "Settings",
              child: Text('Settings'),
            ),
            const PopupMenuItem(
              value: "Logout",
              child: Text('Logout'),
            )
          ], onSelected: (value) => menuSelect(value),);
  }
}