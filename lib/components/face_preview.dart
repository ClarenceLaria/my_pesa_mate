import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';

class FacePreview extends StatefulWidget {
  const FacePreview({
    super.key,
    required this.setSheetState,
  });
  final Function setSheetState;

  @override
  State<FacePreview> createState() => FacePreviewState();
}

class FacePreviewState extends State<FacePreview> {
  late FaceCameraController cameraController;
  // bool faceDetected = false;

  @override
  void initState() {
    cameraController = FaceCameraController(
      autoCapture: false,
      defaultCameraLens: CameraLens.front,
      onCapture: (image) async {
        await Future.delayed(const Duration(seconds: 1));
          widget.setSheetState(() {
          // widget.success = true;
          // widget.scanState = 'done';
        });
      },
      onFaceDetected: (Face? face) {
        //Do something
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 220,
            child: SmartFaceCamera(
              controller: cameraController,
              messageBuilder: (context, faceDetected) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: faceDetected == true ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      faceDetected == true ? 'Face Detected' : 'No Face Found',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}