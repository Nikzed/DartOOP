abstract class IComponent {
  void accept(IVisitor visitor);
}

// Каждый Конкретный Компонент должен реализовать метод Accept таким
// образом, чтобы он вызывал метод посетителя, соответствующий классу
// компонента.
class ComponentA implements IComponent {
// Обратите внимание, мы вызываем VisitConcreteComponentA, что
// соответствует названию текущего класса. Таким образом мы позволяем
// посетителю узнать, с каким классом компонента он работает.

  @override
  void accept(IVisitor visitor) {
    visitor.visitA(this);
  }

// Конкретные Компоненты могут иметь особые методы, не объявленные в их
// базовом классе или интерфейсе. Посетитель всё же может использовать
// эти методы, поскольку он знает о конкретном классе компонента.
  String methodA() {
    return 'A';
  }
}

class ComponentB implements IComponent {
// То же самое здесь: VisitConcreteComponentB => ConcreteComponentB
  @override
  void accept(IVisitor visitor) {
    visitor.visitB(this);
  }

  String methodB() {
    return 'B';
  }
}

// Интерфейс Посетителя объявляет набор методов посещения, соответствующих
// классам компонентов. Сигнатура метода посещения позволяет посетителю
// определить конкретный класс компонента, с которым он имеет дело.
abstract class IVisitor {
  void visitA(ComponentA element);

  void visitB(ComponentB element);
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
class Visitor1 implements IVisitor {
  @override
  void visitA(ComponentA element) {
    print(element.methodA() + ' + ConcreteVisitor1');
  }

  @override
  void visitB(ComponentB element) {
    print(element.methodB() + ' + ConcreteVisitor1');
  }
}

class Visitor2 implements IVisitor {
  @override
  void visitA(ComponentA element) {
    print(
        element.methodA() + ' + ConcreteVisitor2');
  }

  @override
  void visitB(ComponentB element) {
    print(element.methodB() + ' + ConcreteVisitor2');
  }
}

class Client {
  // Клиентский код может выполнять операции посетителя над любым набором
  // элементов, не выясняя их конкретных классов. Операция принятия
  // направляет вызов к соответствующей операции в объекте посетителя.
  static void clientCode(List<IComponent> components, IVisitor visitor) {
    components.forEach((element) {
      element.accept(visitor);
    });
  }
}

void main() {
  List<IComponent> components = [ComponentA(), ComponentB()];

  print(
      'The client code works with all visitors via the base Visitor interface:');
  var visitor1 = Visitor1();
  Client.clientCode(components, visitor1);

  print('');

  print(
      'It allows the same client code to work with different types of visitors:');
  var visitor2 = Visitor2();
  Client.clientCode(components, visitor2);
}
