import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class Veil extends StatelessWidget {
  final ui.Image image;
  final ui.Offset offset;
  final double radius;
  final Widget? child;

  const Veil({
    Key? key,
    required this.image,
    required this.offset,
    required this.radius,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _VeilPainter(
        image: image,
        offset: offset,
        radius: radius,
      ),
      child: child,
    );
  }
}

class _VeilPainter extends CustomPainter {
  final ui.Image image;
  final ui.Offset offset;
  final double radius;

  const _VeilPainter({
    required this.image,
    required this.offset,
    required this.radius,
  });

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final paint = ui.Paint();
    canvas.saveLayer(null, paint);
    canvas.drawImage(image, Offset.zero, paint);
    paint.blendMode = ui.BlendMode.clear;
    canvas.drawCircle(offset, radius, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _VeilPainter oldDelegate) {
    return oldDelegate.image != image ||
        oldDelegate.offset != offset ||
        oldDelegate.radius != radius;
  }

  @override
  bool? hitTest(ui.Offset position) {
    return (position - offset).distance > radius;
  }
}
