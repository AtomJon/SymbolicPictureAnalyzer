

import 'package:flutter/cupertino.dart';

@immutable
class ConstrainedImage extends StatelessWidget {
  const ConstrainedImage(
    {
      super.key,
      required this.image,
      this.heightFactor = 0.6,
      this.widthFactor = 0.6
    }
  );
  
  final ImageProvider image;
  
  final double heightFactor, widthFactor;
  
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final imageHeight = h * heightFactor;
    final imageWidth = w * widthFactor;
    
    return SizedBox
    (
      height: imageHeight,
      width: imageWidth,
      child: Image(
        image: image,
        fit: BoxFit.contain,
      ),
    );
  }
  
}
