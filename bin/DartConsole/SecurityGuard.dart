import 'Gender.dart';
import 'Worker.dart';

class SecurityGuard extends Worker {
  @override
  var salary = 700;

  SecurityGuard(String name, int age) : super(name, age);
}
