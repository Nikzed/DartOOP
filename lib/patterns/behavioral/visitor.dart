abstract class IComponent {
  void Accept(IVisitor visitor);
}

// Каждый Конкретный Компонент должен реализовать метод Accept таким
// образом, чтобы он вызывал метод посетителя, соответствующий классу
// компонента.
class ConcreteComponentA implements IComponent {
// Обратите внимание, мы вызываем VisitConcreteComponentA, что
// соответствует названию текущего класса. Таким образом мы позволяем
// посетителю узнать, с каким классом компонента он работает.

  void Accept(IVisitor visitor) {
    visitor.VisitConcreteComponentA(this);
  }

// Конкретные Компоненты могут иметь особые методы, не объявленные в их
// базовом классе или интерфейсе. Посетитель всё же может использовать
// эти методы, поскольку он знает о конкретном классе компонента.
  String ExclusiveMethodOfConcreteComponentA() {
    return "A";
  }
}

class ConcreteComponentB implements IComponent {
// То же самое здесь: VisitConcreteComponentB => ConcreteComponentB
  void Accept(IVisitor visitor) {
    visitor.VisitConcreteComponentB(this);
  }

  String SpecialMethodOfConcreteComponentB() {
    return "B";
  }
}

// Интерфейс Посетителя объявляет набор методов посещения, соответствующих
// классам компонентов. Сигнатура метода посещения позволяет посетителю
// определить конкретный класс компонента, с которым он имеет дело.
abstract class IVisitor {
  void VisitConcreteComponentA(ConcreteComponentA element);

  void VisitConcreteComponentB(ConcreteComponentB element);
}

// Конкретные Посетители реализуют несколько версий одного и того же
// алгоритма, которые могут работать со всеми классами конкретных
// компонентов.
//
// Максимальную выгоду от паттерна Посетитель вы почувствуете, используя его
// со сложной структурой объектов, такой как дерево Компоновщика. В этом
// случае было бы полезно хранить некоторое промежуточное состояние
// алгоритма при выполнении методов посетителя над различными объектами
// структуры.
class ConcreteVisitor1 implements IVisitor {
  void VisitConcreteComponentA(ConcreteComponentA element) {
    print(
        element.ExclusiveMethodOfConcreteComponentA() + " + ConcreteVisitor1");
  }

  void VisitConcreteComponentB(ConcreteComponentB element) {
    print(element.SpecialMethodOfConcreteComponentB() + " + ConcreteVisitor1");
  }
}

class ConcreteVisitor2 implements IVisitor {
  void VisitConcreteComponentA(ConcreteComponentA element) {
    print(
        element.ExclusiveMethodOfConcreteComponentA() + " + ConcreteVisitor2");
  }

  void VisitConcreteComponentB(ConcreteComponentB element) {
    print(element.SpecialMethodOfConcreteComponentB() + " + ConcreteVisitor2");
  }
}

class Client {
  // Клиентский код может выполнять операции посетителя над любым набором
  // элементов, не выясняя их конкретных классов. Операция принятия
  // направляет вызов к соответствующей операции в объекте посетителя.
  static void ClientCode(List<IComponent> components, IVisitor visitor) {
    components.forEach((element) {
      element.Accept(visitor);
    });
  }
}

void main() {
  List<IComponent> components = [ConcreteComponentA(), ConcreteComponentB()];

  print(
      'The client code works with all visitors via the base Visitor interface:');
  var visitor1 = ConcreteVisitor1();
  Client.ClientCode(components, visitor1);

  print('');

  print(
      'It allows the same client code to work with different types of visitors:');
  var visitor2 = ConcreteVisitor2();
  Client.ClientCode(components, visitor2);
}
