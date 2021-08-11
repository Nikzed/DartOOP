import 'dart:io';
import 'Building.dart';

class House implements Building {
  @override
  void build() {
    print('HOUSE');
    print('building fundament...');
    sleep(Duration(seconds: 1));
    print('building floors...');
    sleep(Duration(seconds: 1));
    print('building roof...');
    sleep(Duration(seconds: 1));
    print('House is done!');
  }
}
