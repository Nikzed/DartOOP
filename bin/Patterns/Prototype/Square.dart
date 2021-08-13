import 'dart:math';
import 'Parallelogram.dart';

class Square {
  var a;
  Square(a) : super();

  factory Square._clone(Square square) {
    return Square(square.a);
  }
  double getInnerRadius() {
    return a / 2;
  }

  double getOuterRadius() {
    return a / sqrt(2);
  }

  Square clone() {
    return Square._clone(this);
  }

  String getInfo() {
    return 'your sides is $a';
  }
}
