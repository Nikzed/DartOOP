import 'dart:io';

// реализуем паттерн позволяющий пользоваться единственным экземпляром класса
// общий глобальный класс
void main() {
  print('Если значения одинаковые, то класс был переиспользован'
      '\n'
      'Если разные, то было создано несколько экземпляров класса'
      '\n\n'
      'RESULT:');
  var singleton = Singleton.getInstance('Значение 455');
  var singleton2 = Singleton.getInstance('Значение 222');
  print(singleton.value);
  print(singleton2.value);
}

class Singleton {
  static var instance;
  String value;

  Singleton(String value) {
    sleep(Duration(seconds: 1));
    this.value = value;
  }

  static Singleton getInstance(String value) {
    // null check
    instance ??= Singleton(value);
    return instance;
  }
}
