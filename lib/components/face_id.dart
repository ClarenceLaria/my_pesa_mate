import 'package:flutter/material.dart';
import 'package:kurerefinancialplanner_app/components/entry_point.dart';

class FaceId extends StatefulWidget {
  const FaceId({super.key});

  @override
  State<FaceId> createState() => _FaceIdState();
}

class _FaceIdState extends State<FaceId> {
  String scanState = 'start';
  bool success = true;

  void _showFaceScanDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            void startScan() async {
              setSheetState(() => scanState = 'scanning');

              await Future.delayed(const Duration(seconds: 3));

              bool isSuccess = DateTime.now().second % 2 == 0;

              setSheetState(() {
                success = isSuccess;
                scanState = 'done';
              });
            }

            return SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  height: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (scanState == 'start') ...[
                        const Icon(Icons.face, size: 80, color: Colors.green),
                        const SizedBox(height: 16),
                        const Text('Face ID Authentication',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        const Text('Tap below to start scanning your face.'),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: startScan,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text('Start Scan', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                      if (scanState == 'scanning') ...[
                        const Icon(Icons.face_retouching_natural,
                            size: 80, color: Colors.greenAccent),
                        const SizedBox(height: 16),
                        const Text('Scanning your face...',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 12),
                        const Text(
                          'Please hold your device steady and look into the camera.',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        const CircularProgressIndicator(),
                      ],
                      if (scanState == 'done') ...[
                        Icon(
                          success ? Icons.check_circle : Icons.error,
                          size: 80,
                          color: success ? Colors.green : Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          success ? 'Identity Verified' : 'Face Not Recognized',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          success
                              ? 'You’re successfully verified. Welcome back!'
                              : 'Please try again in good lighting and face the camera.',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            if (success) {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const EntryPoint()),
                              );
                            } else {
                              setSheetState(() => scanState = 'start');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: success ? Colors.green : Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: Text(
                            success ? 'Continue' : 'Try Again',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Reset state on tap
        setState(() {
          scanState = 'start';
          success = true;
        });
        _showFaceScanDialog(context);
      },
      child: const Column(
        children: [
          Icon(Icons.face, size: 60),
          SizedBox(height: 5),
          Text('Face Scan', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
