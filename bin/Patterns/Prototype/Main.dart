import 'Rectangle.dart';
import 'Square.dart';

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
