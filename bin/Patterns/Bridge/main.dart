class Remote {
  Device _device;

  Remote(Device device) {
    _device = device;
  }

  void togglePower() {
    if (_device.isEnabled()) {
      _device.enabled = false;
    } else {
      _device.enabled = true;
    }
  }

  void volumeDown() {
    _device.setVolume(_device.getVolume() - 10);
  }
}

abstract class Device {
  bool enabled;
  int volume;

  bool isEnabled() {
    return enabled;
  }

  void setVolume(int volume) {
    this.volume = volume;
  }

  int getVolume() {
    return volume;
  }
}

// IMPLEMENT
// class TV implements Device {}
