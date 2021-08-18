abstract class ITarget {
  String getRequest(List<int> name);
}

class Adaptee {
  String getFirstMessage(String name) {
    return 'Welcome to my program $name!';
  }
}

class Adapter implements ITarget {
  Adaptee _adaptee;

  Adapter(this._adaptee);

  @override
  String getRequest(List<int> name) {
    return _adaptee.getFirstMessage(String.fromCharCodes(name));
  }
}

void main() {
  final incompatibleClass = Adaptee();
  final adapter = Adapter(incompatibleClass);

  print('Мы бы не смогли пользоваться методом класса "Adaptee"\n'
      'не используя адаптер, который конвертирует код \nиз UTF-16 в текст\n');
  List<int> codeUnits = [77, 117, 115, 105, 99, 120, 0x1D11E]; // UTF-16 CODE
  print(adapter.getRequest(codeUnits));
}
