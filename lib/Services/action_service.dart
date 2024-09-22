import 'dart:convert';

import 'package:aa_smart_home/Models/action_auth_object.dart';
import 'package:aa_smart_home/Models/action_object.dart';
import 'package:aa_smart_home/Services/secure_storage_service.dart';

class ActionService {
  static const _sercureService =
      SecureStorageService(); //Saving in secure storage for now

  Future<void> SaveNewAction(String name, int iconID, String url,
      String actionType, int authType, Map<String, String> headers) async {
    var jsonActions = await _sercureService.readSecureData("userCustomActions");
    List<ActionObject> actions = List.empty(growable: true);
    var length = 1;

    if (jsonActions != "No data found!") {
      Iterable l = jsonDecode(jsonActions);
      actions = List<ActionObject>.from(
          l.map((model) => ActionObject.fromJson(model)));
          length = actions.length;
          length++;
    }

    var authInfo = ActionAuthObject(AuthType: authType, Headers: headers);
    var action = ActionObject(
        ID: length,
        ActionName: name,
        IconID: iconID,
        ActionURL: url,
        ActionType: actionType,
        AuthInfo: authInfo);

    actions.add(action);

    _sercureService.writeSecureData("userCustomActions", jsonEncode(actions));
  }

  Future<List<ActionObject>> GetActions() async {
    var jsonActions = await _sercureService.readSecureData("userCustomActions");
          List<ActionObject> actions = List.empty(growable: true);
    if (jsonActions != "No data found!") {
      Iterable l = jsonDecode(jsonActions);
      actions =
          List<ActionObject>.from(l.map((model) => ActionObject.fromJson(model)));
    }

    return actions;
  }

  Future<void> UpdateAction(int id, ActionObject action) async {
    var jsonActions = await _sercureService.readSecureData("userCustomActions");
    Iterable l = jsonDecode(jsonActions);
    List<ActionObject> actions =
        List<ActionObject>.from(l.map((model) => ActionObject.fromJson(model)));

    actions.removeWhere((x) => x.ID == id);
    actions.add(action);

    await _sercureService.deleteSecureData("userCustomActions");
    await _sercureService.writeSecureData(
        "userCustomActions", jsonEncode(actions));
  }
}
