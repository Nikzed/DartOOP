import 'dart:io';

import 'Building.dart';

class Skyscraper implements Building {
  @override
  void build() {
    print('SKYSCRAPER');
    print('building fundament...');
    sleep(Duration(seconds: 1));
    print('building floors...');
    sleep(Duration(seconds: 3));
    print('building elevator...');
    sleep(Duration(seconds: 1));
    print('building roof...');
    sleep(Duration(seconds: 1));
    print('Skyscraper is done!');
  }
}
