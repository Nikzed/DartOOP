import 'dart:math';
import 'Parallelogram.dart';

class Square extends Parallelogram {
  Square(a) : super(a, a, a);

  double getInnerRadius() {
    return a / 2;
  }

  double getOuterRadius() {
    return a / sqrt(2);
  }

  @override
  Square clone() {
    return Square(a);
  }
}
