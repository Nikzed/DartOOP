abstract class Subject {
  void request();
}

class RealSubject implements Subject {
  @override
  void request() {
    print('RealSubject: Handling Request.');
  }
}

class Proxy implements Subject {
  RealSubject _realSubject;

  Proxy(RealSubject _realSubject) {
    this._realSubject = _realSubject;
  }

  void request() {
    if (checkAccess()) {
      this._realSubject.request();
      this.logAccess();
    }
  }

  bool checkAccess() {
    // Some real checks should go here.
    print('proxy: Checking access prior to firing a real request.');

    return true;
  }

  void logAccess() {
    print('proxy: Logging the time of request.');
  }
}

class Client {
  void clientCode(Subject subject) {
    subject.request();
  }
}

void main() {
  // Client client = Client();
  //
  // print("Client: Executing the client code with a REAL subject:");
  // RealSubject realSubject = RealSubject();
  // client.clientCode(realSubject);
  //
  // print("\nClient: Executing the client code with a PROXY:");
  // // прослойка между клиентом и реальным объектом,
  // // а затем передаёт вызов сервисному объекту
  // Proxy proxy = Proxy(realSubject);
  // client.clientCode(proxy);
  //
  //

  print("nikita super");
}
