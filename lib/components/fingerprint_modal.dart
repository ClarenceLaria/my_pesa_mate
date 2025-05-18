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

  void _authenticate() async {
    final isAuthenticated =
        await _localAuthService.authenticateWithBiometrics();
    if (!mounted) return;

    if (isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication successful'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EntryPoint()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication failed'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _authenticate,
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
