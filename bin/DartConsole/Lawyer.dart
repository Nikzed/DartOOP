import 'Worker.dart';

class Lawyer extends Worker {
  @override
  var salary = 1200;

  Lawyer(String name, int age) : super(name, age);
}
