import 'package:aa_smart_home/Services/action_service.dart';
import 'package:aa_smart_home/Views/service_view.dart';
import 'package:flutter/material.dart';

class ConfigView extends StatefulWidget {
  const ConfigView({super.key});

  @override
  State<ConfigView> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigView> {
  static final _actionService = ActionService();
  List<Widget> _widgets = List.empty(growable: true);


  Future<List<Widget>> GetCurrentActions() async {
    var actions = await _actionService.GetActions();
    List<Widget> widgets = List.empty(growable: true);
    for (var action in actions) {
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Text(action.ActionName), ElevatedButton(onPressed: () {}, child: const Text("Edit"))],
      ));
    }

    setState(() {
      _widgets = widgets;
    });

    return widgets;
  }

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
                    await GetCurrentActions();
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: _widgets
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
