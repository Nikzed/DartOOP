import 'dart:math';

import 'Cloneable.dart';

// Что такое 'with' в Dart, отличие implements от extends
abstract class Parallelogram implements Cloneable {
  var a;
  var b;
  var height;

  Parallelogram(var side1, var side2, var height) {
    if (height > side1) {
      throw ArgumentError('Parallelogram does not exist');
    }
    a = side1;
    b = side2;
    this.height = height;
  }

  int getArea() {
    return b * height;
  }

  String getInfo() {
    return 'first side is: $a, second side: $b, height: $height';
  }

  @override
  Parallelogram clone();
  /*{
    return Parallelogram(a, b, height);
  }*/
}
