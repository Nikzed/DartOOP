abstract class ITarget {
  String getRequest(int name);
}

class Adaptee {
  String getFirstMesssage(String name) {
    return 'Welcome to my program $name!';
  }
}

class Adapter implements ITarget {
  Adaptee _adaptee;

  Adapter(Adaptee adaptee) {
    _adaptee = adaptee;
  }

  @override
  String getRequest(int name) {
    var codeUnits = [77, 117, 115, 105, 99, 120, 0x1D11E]; // UTF-16 CODE
    return _adaptee.getFirstMesssage(String.fromCharCodes(codeUnits));
  }
}

void main() {
  var incompatibleClass = Adaptee();
  var adapter = Adapter(incompatibleClass);

  print('Мы бы не смогли пользоваться методом класса "Adaptee"\n'
      'не используя адаптер, который конвертирует код \nиз UTF-16 в текст\n');

  print(adapter.getRequest(5));
}
