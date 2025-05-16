import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticateWithBiometrics() async {
    final isAvailable = await auth.canCheckBiometrics;
    if (!isAvailable) return false;

    final isAuthenticated = await auth.authenticate(
      localizedReason: 'Authenticate to access the app',
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );

    return isAuthenticated;
  }

  Future<bool> isBiometricAvailable() async {
    return await auth.canCheckBiometrics;
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await auth.getAvailableBiometrics();
  }
}
