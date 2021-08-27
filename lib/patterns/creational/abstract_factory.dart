import 'dart:io';

abstract class Greeting {
  void paint();
}

class AndroidGreeting implements Greeting {
  @override
  void paint() {
    print('you created AndroidGreeting');
  }
}

class IOSGreeting implements Greeting {
  @override
  void paint() {
    print('you created IOSGreeting');
  }
}

class WindowsGreeting implements Greeting {
  @override
  void paint() {
    print('you created WindowsGreeting');
  }
}

abstract class ButtonBack {
  void paint();
}

class AndroidButtonBack implements ButtonBack {
  @override
  void paint() {
    print('you created AndroidButtonBack');
  }
}

class IOSButtonBack implements ButtonBack {
  @override
  void paint() {
    print('you created IOSButtonBack');
  }
}

class WindowsButtonBack implements ButtonBack {
  @override
  void paint() {
    print('you created WindowsButtonBack');
  }
}

abstract class GUIFactory {
  Greeting createGreeting();
  ButtonBack createButtonBack();
}

class AndroidFactory implements GUIFactory {
  @override
  Greeting createGreeting() {
    return AndroidGreeting();
  }

  @override
  ButtonBack createButtonBack() {
    return AndroidButtonBack();
  }
}

class IOSFactory implements GUIFactory {
  @override
  Greeting createGreeting() {
    return IOSGreeting();
  }

  @override
  ButtonBack createButtonBack() {
    return IOSButtonBack();
  }
}

class WindowsFactory implements GUIFactory {
  @override
  Greeting createGreeting() {
    return WindowsGreeting();
  }

  @override
  ButtonBack createButtonBack() {
    return WindowsButtonBack();
  }
}

class ClientApplication {
  Greeting _greeting;
  ButtonBack _buttonBack;

  ClientApplication(GUIFactory factory) {
    _greeting = factory.createGreeting();
    _buttonBack = factory.createButtonBack();
  }

  void paint() {
    _greeting.paint();
    _buttonBack.paint();
  }
}

void main() {
  ClientApplication app = configureApplication();
  app.paint();
}

ClientApplication configureApplication() {
  ClientApplication app;
  GUIFactory factory;

  String osName = Platform.operatingSystem;
  switch (osName) {
    case 'android':
      factory = AndroidFactory();
      app = ClientApplication(factory);
      break;
    case 'ios':
      factory = IOSFactory();
      app = ClientApplication(factory);
      break;
    case 'windows':
      factory = WindowsFactory();
      app = ClientApplication(factory);
      break;
  }
  return app;
}
