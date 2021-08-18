import 'dart:math';

import 'building.dart';
import 'house.dart';
import 'skyscraper.dart';

class Factory {
  Building b;
  int r = Random().nextInt(4);

  Building createBuilding() {
    if (r > 1) {
      b = Skyscraper();
    } else {
      b = House();
    }
    return b;
  }
}
