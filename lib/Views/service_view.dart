import 'package:flutter/material.dart';

class ServiceView extends StatefulWidget {
  final bool isEdit;
  final int actionID;

  const ServiceView({super.key, required this.isEdit, required this.actionID});

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  //TODO: Load action by ID if isEdit is true and display it in the title
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.isEdit ? "Edit" : "Create"} Action"),
      ),
      body: Text("Action ID: ${widget.actionID} || IsEdit: ${widget.isEdit}"),
    );
  }
}
