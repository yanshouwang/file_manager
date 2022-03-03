import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ClipImage extends StatelessWidget {
  final ui.Image image;
  final ui.Offset offset;
  final double radius;

  const ClipImage({
    Key? key,
    required this.image,
    required this.offset,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipImagePainter(
        image: image,
        offset: offset,
        radius: radius,
      ),
    );
  }
}

class _ClipImagePainter extends CustomPainter {
  final ui.Image image;
  final ui.Offset offset;
  final double radius;

  const _ClipImagePainter({
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
  bool shouldRepaint(covariant _ClipImagePainter oldDelegate) {
    return oldDelegate.image != image ||
        oldDelegate.offset != offset ||
        oldDelegate.radius != radius;
  }

  @override
  bool? hitTest(ui.Offset position) {
    return (position - offset).distance > radius;
  }
}
