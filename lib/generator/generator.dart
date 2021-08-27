import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

void main() async {
  List<Worker> workers = await generateWorkers();
  for (Worker w in workers) {
    print(w.getInfo());
  }
}

Future<List<Worker>> generateWorkers() async {
  var w = <Worker>[];
  var names = await generateNames();
  var ages = generateAge();
  for (var i = 0; i < 10; i++) {
    if (Random().nextInt(3) > 0) {
      w.add(Lawyer(names[i], ages[i]));
    } else {
      w.add(SecurityGuard(names[i], ages[i]));
    }
  }
  return w;
}

Future<List<String>> generateNames() async {
  final response = await http.Client()
      .get(Uri.parse('https://www.name-generator.org.uk/quick/'));

  var names = <String>[];
  if (response.statusCode == 200) {
    var document = parse(response.body);

    for (var i = 0; i < 10; i++) {
      names.add(document
          .getElementsByClassName('name_heading')[i]
          .text
          .split(' ')[0]);
    }
  } else {
    throw Exception();
  }
  return names;
}

List<int> generateAge() {
  var ages = <int>[];
  for (var i = 0; i < 10; i++) {
    ages.add(Random().nextInt(40) + 18);
  }
  return ages;
}

enum Gender { MALE, FEMALE }

class Human {
  String name;
  int age;

  Human(String name, int age) {
    this.name = name;
    this.age = age;
  }
}

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

class Lawyer extends Worker {
  @override
  var salary = 1200;

  Lawyer(String name, int age) : super(name, age);
}

class SecurityGuard extends Worker {
  @override
  var salary = 700;

  SecurityGuard(String name, int age) : super(name, age);
}
