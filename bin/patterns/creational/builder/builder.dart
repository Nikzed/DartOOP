class Car {
  bool gps;
  int seats;
}

class Manual {
  String gps;
  String seats;

  // нарушает ли это идеологию Билдера?
  String getInfo() {
    return gps + '\n' + seats ?? "info isn't specified";
  }
}

abstract class Builder {
  void reset();
  void setSeats([int seats]);
  void setGPS(bool b);
}

class CarBuilder implements Builder {
  Car _car = Car();

  @override
  void reset() {
    _car = Car();
  }

  @override
  void setSeats([int seats = 4]) {
    _car.seats = seats;
  }

  @override
  void setGPS(bool b) {
    _car.gps = b;
  }

  Car getResult() {
    return _car;
  }
}

class ManualBuilder implements Builder {
  Manual _carManual = Manual();

  @override
  void reset() {
    _carManual = Manual();
  }

  @override
  void setGPS(bool b) {
    _carManual.gps = b ? 'you have GPS installed' : "you don't have GPS";
  }

  @override
  void setSeats([int seats = 4]) {
    _carManual.seats = 'you have $seats seats';
  }

  Manual getResult() {
    return _carManual;
  }
}

class Director {
  void constructSportsCar(Builder builder) {
    builder
      ..reset()
      ..setSeats(2)
      ..setGPS(true);
  }
}

void main() {
  Director director = Director();

  CarBuilder carBuilder = CarBuilder();
  director.constructSportsCar(carBuilder);
  Car car = carBuilder.getResult();

  ManualBuilder manualBuilder = ManualBuilder();
  director.constructSportsCar(manualBuilder);

  Manual manual = manualBuilder.getResult();
}

// фишка билдера в том, что есть возможность
// не создавать конструктор с огромным кол-вом
// параметров, вместо этого можно просто задать
// автоматические базовые значения
