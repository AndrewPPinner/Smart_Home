import 'package:aa_smart_home/Models/action_auth_object.dart';

class ActionObject {
  final int ID;
  final String ActionName;
  final int IconID;
  final String ActionURL;
  final String ActionType; //TODO: Turn this to enum
  final ActionAuthObject AuthInfo;

  const ActionObject(
      {required this.ID,
      required this.ActionName,
      required this.IconID,
      required this.ActionURL,
      required this.ActionType,
      required this.AuthInfo});

  factory ActionObject.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "ID": int id,
        "ActionName": String name,
        "IconID": int iconId,
        "ActionURL": String url,
        "ActionType": String actionType,
        "ActionAuth": Map<String, dynamic> authJson
      } =>
        ActionObject(
            ID: id,
            ActionName: name,
            IconID: iconId,
            ActionURL: url,
            ActionType: actionType,
            AuthInfo: ActionAuthObject.fromJson(authJson)),
      _ => throw const FormatException("Failed to format object.")
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "ID": ID,
      "ActionName": ActionName,
      "IconID": IconID,
      "ActionURL": ActionURL,
      "ActionType": ActionType,
      "ActionAuth": AuthInfo
    };
  }
}
