class Remote {
  Device _device;

  Remote(Device device) {
    _device = device;
  }

  void togglePower() {
    if (_device.isEnabled()) {
      _device.enable();
    } else {
      _device.disable();
    }
  }

  void volumeDown() {
    _device.setVolume(_device.getVolume() - 10);
  }
}

class AdvancedRemote extends Remote{

  AdvancedRemote(Device device) : super(device);

  void mute(){
    _device.setVolume(0);
  }

}

abstract class Device {bool isEnabled();
  void enable();
  void disable();
  int getVolume();
  void setVolume(int volume);
  int getChannel();
  void setChannel(int channel);
}

class TV implements Device {

  bool _enabled;
  int _volume;
  int _channel;


  TV(){
    _enabled = false;
    _volume = 0;
    _channel = 0;
  }

  @override
  bool isEnabled() {
    return _enabled;
  }

  @override
  void enable() {
    _enabled = true;
  }

  @override
  void disable() {
    _enabled = false;
  }

  @override
  int getVolume() {
    return _volume;
  }

  @override
  void setVolume(int volume) {
    _volume = volume;
  }

  @override
  int getChannel() {
    return _channel;
  }

  @override
  void setChannel(int channel) {
    _channel = channel;
  }

}

class Radio implements Device{

  bool _enabled;
  int _volume;
  // КАК ПОМЕНЯТЬ ТИП не задевая интерфейс
  int _channel;

  Radio(){
    _enabled = false;
    _volume = 0;
    _channel = 0;
  }

  @override
  bool isEnabled() {
    return _enabled;
  }

  @override
  void enable() {
    _enabled = true;
  }

  @override
  void disable() {
    _enabled = false;
  }

  @override
  int getVolume() {
    return _volume;
  }

  @override
  void setVolume(int volume) {
    _volume = volume;
  }

  @override
  int getChannel() {
    return _channel;
  }

  @override
  void setChannel(int channel) {
    _channel = channel;
  }
}

void main(){
  TV tv = TV();
  Remote remote = new Remote(tv);
  remote.togglePower();

  Radio radio = Radio();
  remote = AdvancedRemote(radio);
}
