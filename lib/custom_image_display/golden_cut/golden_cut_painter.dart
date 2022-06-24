import 'package:flutter/rendering.dart';

import 'golden_cut.dart';

class GoldenCutPainterOptions {
  GoldenCutPainterOptions({
    required this.paint,
    required this.applyGoldenCut
  });
  
  final Paint paint;
  final bool applyGoldenCut;
}

class GoldenCutPainter extends CustomPainter {
  GoldenCutPainter({required this.options}) {
    _goldenCutDrawer = GoldenCutDrawer(options.paint);
  }
  
  final GoldenCutPainterOptions options;
  
  late final GoldenCutDrawer _goldenCutDrawer;

  @override
  void paint(Canvas canvas, Size size) {
    if (options.applyGoldenCut)
      _goldenCutDrawer.drawGoldenCut(canvas, size);    
  }

  @override
  bool shouldRepaint(covariant GoldenCutPainter oldDelegate) {
    return oldDelegate.options != options;
  }
}
