import 'dart:math';

import 'lawyer.dart';
import 'security_guard.dart';
import 'worker.dart';
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
