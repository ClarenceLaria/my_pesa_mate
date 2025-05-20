import 'package:flutter/material.dart';
import 'package:kurerefinancialplanner_app/auth/auth_helper.dart';
import 'package:kurerefinancialplanner_app/components/face_id.dart';
import 'package:kurerefinancialplanner_app/components/fingerprint_modal.dart';
import 'package:local_auth/local_auth.dart';

class BiometricsModal extends StatefulWidget {
  const BiometricsModal({super.key});

  @override
  State<BiometricsModal> createState() => _BiometricsModalState();
}

class _BiometricsModalState extends State<BiometricsModal> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<List<BiometricType>> _getAvailableBiometrics() {
    return auth.getAvailableBiometrics();
  }

  final available = LocalAuthService().auth.getAvailableBiometrics();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getAvailableBiometrics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Text("Error checking biometrics");
        }

        final biometrics = snapshot.data!;
        final hasFingerprint = biometrics.contains(BiometricType.fingerprint);
        final hasFace = biometrics.contains(BiometricType.face);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (hasFingerprint && hasFace) ...[
              const FingerprintModal(),
              const FaceId()
            ] else const FingerprintModal(),
          ],
        );
      },
    );
  }
}
