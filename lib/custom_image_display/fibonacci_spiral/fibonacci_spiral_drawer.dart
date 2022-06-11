import 'dart:math';

import 'package:flutter/rendering.dart';
import 'fibonacci_spiral.dart';

class FibonacciSpiralDrawer {
  FibonacciSpiralDrawer({
    required this.paint,
    required this.spiralScale,
    required this.spiralRadius 
  });
  
  final Paint paint;
  
  double? spiralScale;
  double? spiralRadius;
  
  double get scale => spiralScale == null ? 2 : spiralScale!;
  double get radius => spiralRadius == null ? 8 : spiralRadius!;
  
  void drawFibonacciSpiral(Canvas canvas, Size size)
  {    
    final spiral = getSpiralVertices(
      const Point(0, 0),
      const Point(0, 1),
      scale // 330
    );
    
    for (final element in spiral) {      
      final pointInSpace = Offset(
        element.x.toDouble(),
        element.y.toDouble()
      );
      
      final scaledPoint = pointInSpace;
      
      // print(scale);
      
      // final idk = Size(
      //   size.width,
      //   size.height
      // );
      
      // final actualPoint = (idk).center(scaledPoint);
      
      final actualPoint = Size.fromRadius(scale / 2).center(scaledPoint);
            
      // final actualPoint = Offset(
      //   scaledPoint.dx - scale / 2,
      //   scaledPoint.dy - scale / 2
      // );
      
      // print(actualPoint);
      
      canvas.drawCircle(actualPoint, 1, paint);
    }
  }
}
