// Абстрактный Класс определяет шаблонный метод, содержащий скелет
// некоторого алгоритма, состоящего из вызовов (обычно) абстрактных
// примитивных операций.
//
// Конкретные подклассы должны реализовать эти операции, но оставить сам
// шаблонный метод без изменений.
abstract class AbstractClass
{
  // Шаблонный метод определяет скелет алгоритма.
  void TemplateMethod()
  {
    this.BaseOperation1();
    this.RequiredOperations1();
    this.BaseOperation2();
    this.Hook1();
    this.RequiredOperation2();
    this.BaseOperation3();
    this.Hook2();
  }

  // Эти операции уже имеют реализации.
  void BaseOperation1()
  {
    print("AbstractClass says: I am doing the bulk of the work");
  }

  void BaseOperation2()
  {
    print("AbstractClass says: But I let subclasses override some operations");
  }

  void BaseOperation3()
  {
    print("AbstractClass says: But I am doing the bulk of the work anyway");
  }

  // А эти операции должны быть реализованы в подклассах.
  void RequiredOperations1();

  void RequiredOperation2();

  // Это «хуки». Подклассы могут переопределять их, но это не обязательно,
  // поскольку у хуков уже есть стандартная (но пустая) реализация. Хуки
  // предоставляют дополнительные точки расширения в некоторых критических
  // местах алгоритма.
  void Hook1() { }

  void Hook2() { }
}

// Конкретные классы должны реализовать все абстрактные операции базового
// класса. Они также могут переопределить некоторые операции с реализацией
// по умолчанию.
class ConcreteClass1 extends AbstractClass
{
  void RequiredOperations1()
{
  print("ConcreteClass1 says: Implemented Operation1");
}

void RequiredOperation2()
{
  print("ConcreteClass1 says: Implemented Operation2");
}
}

// Обычно конкретные классы переопределяют только часть операций базового
// класса.
class ConcreteClass2 extends AbstractClass
{
  void RequiredOperations1()
{
  print("ConcreteClass2 says: Implemented Operation1");
}

void RequiredOperation2()
{
  print("ConcreteClass2 says: Implemented Operation2");
}

void Hook1()
{
  print("ConcreteClass2 says: Overridden Hook1");
}
}

class Client
{
  // Клиентский код вызывает шаблонный метод для выполнения алгоритма.
  // Клиентский код не должен знать конкретный класс объекта, с которым
  // работает, при условии, что он работает с объектами через интерфейс их
  // базового класса.
  static void ClientCode(AbstractClass abstractClass)
  {
    // ...
    abstractClass.TemplateMethod();
    // ...
  }
}

void main(){
  print("Same client code can work with different subclasses:");

  Client.ClientCode(new ConcreteClass1());

  print("\n");

  print("Same client code can work with different subclasses:");
  Client.ClientCode(new ConcreteClass2());

}