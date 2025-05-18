import 'package:flutter/material.dart';
import 'package:kurerefinancialplanner_app/components/face_id.dart';
import 'package:kurerefinancialplanner_app/components/fingerprint_modal.dart';

class BiometricsModal extends StatefulWidget {
  const BiometricsModal({super.key});

  @override
  State<BiometricsModal> createState() => _BiometricsModalState();
}

class _BiometricsModalState extends State<BiometricsModal> {

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FingerprintModal(),
        FaceId(),

      ],
    );
  }
}