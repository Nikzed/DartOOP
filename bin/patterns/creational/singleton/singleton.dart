import 'dart:io';

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
