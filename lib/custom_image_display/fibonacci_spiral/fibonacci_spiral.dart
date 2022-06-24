import 'dart:math';

List<Point> getSpiralVertices(Point pA, Point pB, double maxRadius){
    // 1 step = 1/4 turn or 90º    
    const precision = 50; // Lines to draw in each 1/4 turn
    const stepB = 4; // Steps to get to point B

    final num angleToPointB = getAngle(pA,pB); // Angle between pA and pB
    final num distToPointB = getDistance(pA,pB); // Distance between pA and pB

    final fibonacci = FibonacciGenerator();

    // Find scale so that the last point of the curve is at distance to pB
    final num radiusB = fibonacci.getNumber(stepB);
    final scale = distToPointB / radiusB;

    // Find angle offset so that last point of the curve is at angle to pB
    final angleOffset = angleToPointB - stepB * pi / 2;

    final List<Point> path = [];    
    num i, step , radius, angle;

    // Start at the center
    i = step = radius = angle = 0;

    // Continue drawing until reaching maximum radius
    while (radius * scale <= maxRadius){

      path.add(Point(
        scale * radius * cos(angle + angleOffset) + pA.x,
        scale * radius * sin(angle + angleOffset) + pA.y
      ));

      i++; // Next point
      step = i / precision; // 1/4 turns at point    
      radius = fibonacci.getNumber(step); // Radius of Fibonacci spiral
      angle = step * pi / 2; // Radians at point
    }
    
    return path;
}

class FibonacciGenerator
{
    // Start with 0 1 2... instead of the real sequence 0 1 1 2...
  final List<int> cachedFibonacciList = [0, 1, 2];
  
  int getDiscrete(int n)
  {
    // If the Fibonacci number is not in the array, calculate it
        while (n >= cachedFibonacciList.length){
            final int length = cachedFibonacciList.length;
            final int nextFibonacci = cachedFibonacciList[length - 1] + cachedFibonacciList[length - 2];
            cachedFibonacciList.add(nextFibonacci);
        }

        return cachedFibonacciList[n];
  }
  
  num getNumber(num n)
  {
    final int floor = n.floor();
    final int ceil = n.ceil();

        if (floor == n){
            return getDiscrete(floor);
        }

        final num a = pow(n - floor, 1.15);

        final int fibFloor = getDiscrete(floor);
        final int fibCeil = getDiscrete(ceil);

        return fibFloor + a * (fibCeil - fibFloor);
  }
}

num getDistance(Point p1, Point p2){
    return sqrt(pow(p1.x-p2.x, 2) + pow(p1.y-p2.y, 2));
}

num getAngle(Point p1, Point p2){
    return atan2(p2.y-p1.y, p2.x-p1.x);
}
