import 'dart:math';

import 'Cloneable.dart';

// Что такое 'with' в Dart, отличие implements от extends
class Parallelogram implements Cloneable{

  var a;
  var b;
  var height;

  Parallelogram(var a, var b, var height){
    this.a = a;
    this.b = b;
    this.height = height;
  }

  @override
  Parallelogram clone() {
    return Parallelogram(a, b, height);
  }

  String getIfo() {
    return '';
  }

}