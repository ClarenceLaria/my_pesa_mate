import 'package:flutter/material.dart';
import 'package:kurerefinancialplanner_app/auth/auth_helper.dart';
import 'package:kurerefinancialplanner_app/components/entry_point.dart';

class FingerprintModal extends StatefulWidget {
  const FingerprintModal({super.key});

  @override
  State<FingerprintModal> createState() => _FingerprintModalState();
}

class _FingerprintModalState extends State<FingerprintModal> {
  final LocalAuthService _localAuthService = LocalAuthService();

  void _showBiometricPrompt(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        Future.delayed(Duration.zero, () async {
          final isAuthenticated = await _localAuthService.authenticateWithBiometrics();
          if (!mounted) return;

          Navigator.of(context).pop(); // Close the modal
          if (isAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Authentication successful')),
            );
            // Handle success logic here
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const EntryPoint()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Authentication failed')),
            );
          }
        });
        
        return const SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.fingerprint,
                  size: 80,
                  color: Colors.green,
                ),
                SizedBox(height: 16),
                Text(
                  'Fingerprint Authentication',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Place your finger on the sensor',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 24),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                ),
                SizedBox(height: 24),
                Text(
                  "Waiting for biometric authentication...",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBiometricPrompt(context); // false means fingerprint
      },
      child: const Column(
        children: [
          Icon(Icons.fingerprint, size: 60),
          SizedBox(height: 5),
          Text('Fingerprint Scanner', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
