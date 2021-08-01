import 'dart:math';

import 'Parallelogram.dart';

class Rectangle extends Parallelogram {
  Rectangle(side1, side2) : super(side1, side2, side1);

  double getOuterRadius() {
    return sqrt(pow(a, 2) + pow(b, 2)) / 2;
  }

  @override
  Rectangle clone() {
    return Rectangle(a, b);
  }
}
