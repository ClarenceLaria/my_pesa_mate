import 'package:flutter/material.dart';

class BiometricsModal extends StatefulWidget {
  const BiometricsModal({super.key});

  @override
  State<BiometricsModal> createState() => _BiometricsModalState();
}

class _BiometricsModalState extends State<BiometricsModal> {
  
  void _showBiometricPrompt(BuildContext context, {required bool isFace}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isFace ? Icons.face : Icons.fingerprint,
                  size: 80,
                  color: Colors.green,
                ),
                const SizedBox(height: 16),
                Text(
                  isFace
                      ? 'Face ID Authentication'
                      : 'Fingerprint Authentication',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  isFace
                      ? 'Please align your face with the camera'
                      : 'Place your finger on the sensor',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                ),
                const SizedBox(height: 24),
                const Text(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            _showBiometricPrompt(context, isFace: false); // false means fingerprint
          },
          child: const Column(
            children: [
              Icon(Icons.fingerprint, size: 60),
              SizedBox(height: 5),
              Text('Fingerprint Scanner', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            _showBiometricPrompt(context, isFace: true);
          },
          child: const Column(
            children: [
              Icon(Icons.face, size: 60),
              SizedBox(height: 5),
              Text('Face Scan', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),

      ],
    );
  }
}