import 'dart:convert';

import 'package:aa_smart_home/Models/token_response.dart';
import 'package:aa_smart_home/Services/secure_storage_service.dart';
import 'package:http/http.dart' as http;

class APIService {
  static const _sercureService = SecureStorageService();

  APIService();

  Future<bool> hasExistingValidToken() async {
    var token = await _sercureService.readSecureData("userToken");
    if (_isTokenValid(token)) {
      return true;
    }
    return false;
  }

  Future<bool> loginUser(String user, String pass) async {
    if (user == "" || pass == "") {
      throw Exception("Username or password is invalid.");
    }

    var token = "";
    final res = await http.post(
        Uri.parse("https://andrewp.online/RCON/api/login"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{"Username": user, "Password": pass}));

    if (res.statusCode == 200) {
      token =
          TokenResponse.fromJson(jsonDecode(res.body) as Map<String, dynamic>)
              .Token;
      await _sercureService.writeSecureData("userToken", token);
      return true;
    } else if (res.statusCode == 401) {
      throw Exception("Username or password is invalid.");
    }
    throw Exception("Unexpected issue has occurred.");
  }

  bool _isTokenValid(String token) {
    try {
      var jwt = _parseJwt(token);
      final expirationDate = _getExpirationDate(jwt['exp']);
      return DateTime.now().isBefore(expirationDate);
    } on Exception {
      return false;
    }
  }

  Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload =
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  DateTime _getExpirationDate(int exp) {
    if (exp == 0) return DateTime.now();

    return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
  }
}
