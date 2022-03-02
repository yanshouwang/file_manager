import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ClipImage extends StatefulWidget {
  final ui.Image image;
  final ui.Offset offset;

  const ClipImage({Key? key, required this.image, required this.offset})
      : super(key: key);

  @override
  State<ClipImage> createState() => _ClipImageState();
}

class _ClipImageState extends State<ClipImage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bounds = Offset.zero & mediaQuery.size;
    final d0 = (widget.offset - bounds.topLeft).distance;
    final d1 = (widget.offset - bounds.topRight).distance;
    final d2 = (widget.offset - bounds.bottomRight).distance;
    final d3 = (widget.offset - bounds.bottomLeft).distance;
    final distance = [d0, d1, d2, d3].reduce(math.max);
    final animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    animationController.forward(from: 0.0);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _ClipImagePainter(
            image: widget.image,
            offset: widget.offset,
            radius: distance * animation.value,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
    // canvas.drawImage(image, Offset.zero, paint);
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
