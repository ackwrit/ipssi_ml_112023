import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FacePainter extends CustomPainter {
  Size sizeImage;
  List<Face> objects;
  InputImageRotation rotation = InputImageRotation.rotation0deg;
  FacePainter({required this.sizeImage, required this.objects});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (Face object in objects) {
      final left = paintX(object.boundingBox.left, size, sizeImage);
      final top = paintY(object.boundingBox.top, size, sizeImage);
      final right = paintX(object.boundingBox.right, size, sizeImage);
      final bottom = paintY(object.boundingBox.bottom, size, sizeImage);
      final rect = Rect.fromLTRB(left, top, right, bottom);
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  double paintX(double x, Size size, Size sizeImage) {
    return x * size.width / sizeImage.width;
  }

  double paintY(double y, Size size, Size sizeImage) {
    return y * size.height / sizeImage.height;
  }
}
