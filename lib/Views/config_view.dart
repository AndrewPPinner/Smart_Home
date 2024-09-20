import 'package:aa_smart_home/Views/service_view.dart';
import 'package:flutter/material.dart';

class ConfigView extends StatefulWidget {
  const ConfigView({super.key});

  @override
  State<ConfigView> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Configuration"),
        ),
        body: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 3 / 2,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) => const Dialog(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Data"),
                                    Text("Data"),
                                    Text("Data"),
                                    Text("Data")
                                  ],
                                ),
                              ),
                            ));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.blue),
                  child: const Text("Edit Service")),
              ElevatedButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) => const Dialog.fullscreen(
                              child: ServiceView(
                                isEdit: false,
                                actionID: 0,
                              ),
                            ));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.blue),
                  child: const Text("Add Service"))
            ]));
  }
}
