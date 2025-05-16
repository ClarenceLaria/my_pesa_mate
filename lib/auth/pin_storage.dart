import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinService {
  final _storage = const FlutterSecureStorage();
  final String _pinKey = 'user_pin';

  Future<void> savePin(String pin) async {
    await _storage.write(key: _pinKey, value: pin);
  }

  Future<bool> validatePin(String inputPin) async {
    final storedPin = await _storage.read(key: _pinKey);
    return storedPin == inputPin;
  }

  Future<bool> isPinSet() async {
    final storedPin = await _storage.read(key: _pinKey);
    return storedPin != null;
  }
}
