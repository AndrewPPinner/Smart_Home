import 'package:aa_smart_home/Services/action_service.dart';
import 'package:flutter/material.dart';

class ServiceView extends StatefulWidget {
  final bool isEdit;
  final int actionID;

  const ServiceView({super.key, required this.isEdit, required this.actionID});

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  static final _actionService = ActionService();

  //TODO: Load action by ID if isEdit is true and display it in the title
  //Add delete button top right on edits
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.isEdit ? "Edit" : "Create"} Action"),
      ),
      body: Column(children: [Text("Action ID: ${widget.actionID} || IsEdit: ${widget.isEdit}"),
      ElevatedButton(onPressed: () async {
        await _actionService.SaveNewAction("Test Action", 1, "This is a URL", "POST", 1, {"Test": "Test"});
        await _actionService.SaveNewAction("Test Action 1", 1, "This is a URL 1", "POST", 1, {"Test": "Test1"});
      }, child: Text("Save Action"))]),
    );
  }
}
