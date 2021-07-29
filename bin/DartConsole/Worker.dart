import 'Human.dart';

class Worker extends Human {
  var salary;
  static var count = 100;
  var cardId;

  Worker(String name, int age) : super(name, age) {
    cardId = count++;
  }

  String getInfo() {
    return 'card ID: $cardId, '
        'name: $name, '
        'age is: $age, '
        'salary: ${salary ??= 'undefined'}';
  }
}
