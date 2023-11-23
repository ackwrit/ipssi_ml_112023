import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class MyCustomPainter extends CustomPainter {
  Size imageSize;
  List<Face> faces;
  InputImageRotation rotation = InputImageRotation.rotation0deg;

  MyCustomPainter({required this.faces, required this.imageSize});
  @override
  void paint(Canvas canvas, Size size) async {
    // TODO: implement paint
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.orange;
    for (Face face in faces) {
      final rect = Rect.fromLTWH(face.boundingBox.left, face.boundingBox.top,
          face.boundingBox.width, face.boundingBox.height);
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
