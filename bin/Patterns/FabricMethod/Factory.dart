import 'dart:math';

import 'Building.dart';
import 'House.dart';
import 'Skyscraper.dart';

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
