import 'package:flutter/material.dart';
import 'dart:math' as math;

class EcgLoadingWidget extends StatefulWidget {
  @override
  _EcgLoadingWidgetState createState() => _EcgLoadingWidgetState();
}

class _EcgLoadingWidgetState extends State<EcgLoadingWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        child: CustomPaint(
          painter: EcgPainter(
            animation: _animationController!),
        ),
      ),
    );
  }
}

class EcgPainter extends CustomPainter {
  final Animation<double> animation;

  EcgPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();
    final angle = animation.value * 3.25 * math.pi;

    final startX = 0.0;
    final endX = size.width;
    final centerY = size.height / 1;
    final amplitude = size.height / 5;

    path.moveTo(startX, centerY);

    for (double x = startX; x <= endX; x += 1) {
      final y = centerY +
          math.sin((x / size.width) * 10 * math.pi + angle) * amplitude;
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(EcgPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(EcgPainter oldDelegate) => false;
}
