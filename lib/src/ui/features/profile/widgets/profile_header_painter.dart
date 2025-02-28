import 'package:flutter/material.dart';

/// Paints the background for the profile page header.
class ProfilePainter extends CustomPainter {
  /// Creates a new [ProfilePainter] instance.
  const ProfilePainter(this.color);

  /// The color to paint the background with.
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, size.height * 0.2)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.8,
        size.width,
        size.height * 0.2,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ProfilePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ProfilePainter oldDelegate) => false;
}
