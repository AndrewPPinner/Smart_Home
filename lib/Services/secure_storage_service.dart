import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  const SecureStorageService();

  Future<void> writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

//Turn this into a generic method that returns Object or type
  Future<String> readSecureData(String key) async {
    String value = await storage.read(key: key) ?? 'No data found!';
    return value;
  }

  deleteSecureData(String key) async {
    await storage.delete(key: key);
  }
}
