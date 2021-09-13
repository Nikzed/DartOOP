// Абстрактный Класс определяет шаблонный метод, содержащий скелет
// некоторого алгоритма, состоящего из вызовов (обычно) абстрактных
// примитивных операций.
//
// Конкретные подклассы должны реализовать эти операции, но оставить сам
// шаблонный метод без изменений.
abstract class AbstractClass {
  // Шаблонный метод определяет скелет алгоритма.
  void TemplateMethod() {
    base1();
    required1();
    base2();
    hook1();
    required2();
    base3();
    hook2();
  }

  // Эти операции уже имеют реализации.
  void base1() {
    print('AbstractClass says: I am doing the bulk of the work');
  }

  void base2() {
    print('AbstractClass says: But I let subclasses override some operations');
  }

  void base3() {
    print('AbstractClass says: But I am doing the bulk of the work anyway');
  }

  // А эти операции должны быть реализованы в подклассах.
  void required1();

  void required2();

  // Это «хуки». Подклассы могут переопределять их, но это не обязательно,
  // поскольку у хуков уже есть стандартная (но пустая) реализация. Хуки
  // предоставляют дополнительные точки расширения в некоторых критических
  // местах алгоритма.
  void hook1() {}

  void hook2() {}
}

// Конкретные классы должны реализовать все абстрактные операции базового
// класса. Они также могут переопределить некоторые операции с реализацией
// по умолчанию.
class ConcreteClass1 extends AbstractClass {
  @override
  void required1() {
    print('ConcreteClass1 says: Implemented Operation1');
  }

  @override
  void required2() {
    print('ConcreteClass1 says: Implemented Operation2');
  }
}

// Обычно конкретные классы переопределяют только часть операций базового
// класса.
class ConcreteClass2 extends AbstractClass {
  @override
  void required1() {
    print('ConcreteClass2 says: Implemented Operation1');
  }

  @override
  void required2() {
    print('ConcreteClass2 says: Implemented Operation2');
  }

  @override
  void hook1() {
    print('ConcreteClass2 says: Overridden Hook1');
  }
}

class Client {
  // Клиентский код вызывает шаблонный метод для выполнения алгоритма.
  // Клиентский код не должен знать конкретный класс объекта, с которым
  // работает, при условии, что он работает с объектами через интерфейс их
  // базового класса.
  static void clientCode(AbstractClass abstractClass) {
    // ...
    abstractClass.TemplateMethod();
    // ...
  }
}

void main() {
  print('Same client code can work with different subclasses:');

  Client.clientCode(ConcreteClass1());

  print('');

  print('Same client code can work with different subclasses:');
  Client.clientCode(ConcreteClass2());
}
