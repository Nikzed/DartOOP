void main(){
  print('object');
}

class Car{

  bool gps;
  int seats;

}
class CarManual{}

abstract class Builder{
  void reset();
  void setSeats();
  void setTripComputer();
  void setGPS();
}

class CarBuilder implements Builder{

  Car _car = Car();

  @override
  void reset() {
    // TODO: implement reset
  }

  @override
  void setSeats() {
    // TODO: implement setSeats
  }

  @override
  void setTripComputer() {
    // TODO: implement setTripComputer
  }

  @override
  void setGPS() {
    // TODO: implement setGPS
  }

  Car getResult(){
    return _car;
  }

}