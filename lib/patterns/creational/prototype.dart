import 'dart:math';

abstract class Cloneable {
  Parallelogram clone();
}

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
}

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

class Square {
  var a;
  Square(this.a) : super();

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

// ??реализация приватных переменных в подклассах??
void main() {
  var square1 = Square(10);
  print('square 1\n${square1.getInfo()}');
  print('Inner radius: ${square1.getInnerRadius()}');
  print('Outer radius: ${square1.getOuterRadius().toStringAsFixed(2)}');

  var square2 = square1.clone();
  print('\nsquare2');
  print('Outer radius: ${square2.getOuterRadius()}');

  var rectangle = Rectangle(5, 10);
  print('\nrectangle \n${rectangle.getInfo()}');
  print('area: ${rectangle.getArea()}');
  print(
      'rectangle Outer radius: ${rectangle.getOuterRadius().toStringAsFixed(2)}');

  var rectangle2 = rectangle.clone();
  print('\nrectangle2 \n${rectangle2.getInfo()}');
  print('area: ${rectangle2.getArea()}');
}
