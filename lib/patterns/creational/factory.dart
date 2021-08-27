import 'dart:io';
import 'dart:math';

// Реализация фабричного метода, который который
// определяет общий интерфейс для создания объектов.
// Предполагается создавать объекты классов не напрямую,
// а через отдельный метод
void main() {
  _configure();
}

void _configure() {
  var b = Factory().createBuilding();
  b.build();
}

abstract class Building {
  void build();
}

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
