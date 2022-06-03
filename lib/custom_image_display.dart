import 'package:flutter/cupertino.dart';
import 'package:http/retry.dart';

class CustomImageDisplay extends StatelessWidget {
  const CustomImageDisplay({
    super.key,
    this.applyGoldenCut,
    required this.image
  });
  
  final ImageProvider image;
  final bool? applyGoldenCut;
  
  bool get shouldGoldenCut {
    if (applyGoldenCut == null) return false;
    else return applyGoldenCut!;
  }
  
  // @override
  // State<Image> createState() {
  //   return _CustomImageDisplayState();
  // }
  
  @override
  Widget build(BuildContext context) {    
    return CustomPaint(
      foregroundPainter: _ForegroundPainter(
        drawGoldenCut: shouldGoldenCut,
      ),
      child: Image(image: image,)
    );
  }
}

class _ForegroundPainter extends CustomPainter {
  _ForegroundPainter({
    required this.drawGoldenCut
  });
  
  Paint get _paint => Paint();

  final bool drawGoldenCut;

  @override
  void paint(Canvas canvas, Size size) {
    if (drawGoldenCut)
      _drawGoldenCut(canvas, size);
  }
  
  void _drawGoldenCut(Canvas canvas, Size size) {
    _drawHorizontalGoldenCutLines(canvas, size);
    _drawVerticalGoldenCutLines(canvas, size);
  }
  
  void _drawHorizontalGoldenCutLines(Canvas canvas, Size size) {
    final squares = size.width / 8;
    
    const top = .0;
    final bottom = size.height;
    
    final firstLine = squares * 3;
    canvas.drawLine(Offset(firstLine, top), Offset(firstLine, bottom), _paint);
    
    final secondLine = firstLine + squares * 2;
    canvas.drawLine(Offset(secondLine, top), Offset(secondLine, bottom), _paint);
  }
  
  void _drawVerticalGoldenCutLines(Canvas canvas, Size size) {
    final squares = size.height / 8;
    
    const left = .0;
    final right = size.width;
    
    final firstLine = squares * 3;
    canvas.drawLine(Offset(left, firstLine), Offset(right, firstLine), _paint);
    
    final secondLine = firstLine + squares * 2;
    canvas.drawLine(Offset(left, secondLine), Offset(right, secondLine), _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}

// class _CustomImageDisplayState extends State<CustomImageDisplay> {
//   _CustomImageDisplayState();  
  
//   Image get image => widget;
  
//   @override
//   Widget build(BuildContext context) {
//     return image;
//   }
// }
