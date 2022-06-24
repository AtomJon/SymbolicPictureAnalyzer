import 'dart:math';

import 'package:flutter/material.dart';
import 'fibonacci_spiral.dart';

class FibonacciSpiralOptions {
  FibonacciSpiralOptions({
    required this.paint,
    required this.spiralScale 
  });
  
  final Paint paint;
  
  double? spiralScale;
}

class FibonacciSpiralPainter extends CustomPainter {
  FibonacciSpiralPainter({
    required this.options
  });
  
  late FibonacciSpiralOptions options;
  
  @override
  void paint(Canvas canvas, Size size) {
    final drawer = FibonacciSpiralDrawer(options: options);
    drawer.drawFibonacciSpiral(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}

class FibonacciSpiralDrawer {
  FibonacciSpiralDrawer({
    required this.options
  });
  
  late FibonacciSpiralOptions options;
  
  double get spiralSize => options.spiralScale == null ? 8 : options.spiralScale!;
  
  Paint get paint => options.paint;
  
  void drawFibonacciSpiral(Canvas canvas, Size size)
  {    
    final spiral = getSpiralVertices(
      const Point(0, 0),
      const Point(0, 1),
      2.5
    );
    
    Point mostTopLeftPoint = const Point(0, 0);
    Point mostBotRightPoint = const Point(0, 0);
    for (final element in spiral) {
      if (element.x < mostTopLeftPoint.x) mostTopLeftPoint = Point(element.x, mostTopLeftPoint.y);
      if (element.y < mostTopLeftPoint.y) mostTopLeftPoint = Point(mostTopLeftPoint.x, element.y);
      
      if (element.x > mostBotRightPoint.x) mostBotRightPoint = Point(element.x, mostBotRightPoint.y);
      if (element.y > mostBotRightPoint.y) mostBotRightPoint = Point(mostBotRightPoint.x, element.y);
    }
    
    num sizeScale;
    
    if (mostBotRightPoint.x > mostBotRightPoint.y)
      sizeScale = size.width / mostBotRightPoint.x;
    else
      sizeScale = size.height / mostBotRightPoint.y;
      
    sizeScale *= spiralSize;
    
    Offset offset (Point<num> p) {
      final result = Offset(
        (p.x * sizeScale).roundToDouble() /* + size.width / 2 */,
        (p.y * sizeScale).roundToDouble() /* + size.height / 2 */
      );
      
      return result;
    }
    
    canvas.translate(size.width / 2, size.height / 2 );
    
    // canvas.translate(size.width / 2, size.height / 2);
    
    
    for (int i = 0; i < spiral.length - 1; i++) {
      final currentVertice = spiral[i];
      final nextVertice = spiral[i + 1];
    
      final adjustedCurrent = offset(currentVertice);
      final adjustedNext = offset(nextVertice);
      
      canvas.drawLine(adjustedCurrent, adjustedNext, paint);
    }
  }
}
