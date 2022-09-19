import 'package:flutter/rendering.dart';

class GoldenCutDrawer {
  GoldenCutDrawer(this._paint);

  final Paint _paint;

  void drawGoldenCut(Canvas canvas, Size size) {
    _drawHorizontalGoldenCutLines(canvas, size);
    _drawVerticalGoldenCutLines(canvas, size);
  }

  void _drawHorizontalGoldenCutLines(Canvas canvas, Size size) {
    print(size);
    final squares = size.width / 8;

    const top = .0;
    final bottom = size.height;

    final firstLine = squares * 3;
    canvas.drawLine(Offset(firstLine, top), Offset(firstLine, bottom), _paint);

    final secondLine = firstLine + squares * 2;
    canvas.drawLine(
        Offset(secondLine, top), Offset(secondLine, bottom), _paint);
  }

  void _drawVerticalGoldenCutLines(Canvas canvas, Size size) {
    final squares = size.height / 8;

    const left = .0;
    final right = size.width;

    final firstLine = squares * 3;
    canvas.drawLine(Offset(left, firstLine), Offset(right, firstLine), _paint);

    final secondLine = firstLine + squares * 2;
    canvas.drawLine(
        Offset(left, secondLine), Offset(right, secondLine), _paint);
  }
}
