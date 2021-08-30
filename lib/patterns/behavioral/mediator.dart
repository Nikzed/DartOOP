// Интерфейс Посредника предоставляет метод, используемый компонентами для
// уведомления посредника о различных событиях. Посредник может реагировать
// на эти события  и передавать исполнение другим компонентам.
abstract class IMediator {
  void Notify(Object sender, String ev);
}

// Конкретные Посредники реализуют совместное поведение, координируя
// отдельные компоненты.
class ConcreteMediator implements IMediator {
  Component1 _component1;

  Component2 _component2;

  ConcreteMediator(Component1 component1, Component2 component2) {
    this._component1 = component1;
    this._component1.SetMediator(this);
    this._component2 = component2;
    this._component2.SetMediator(this);
  }

  void Notify(Object sender, String ev) {
    if (ev == "A") {
      print("Mediator reacts on A and triggers folowing operations:");
      this._component2.DoC();
    }
    if (ev == "D") {
      print("Mediator reacts on D and triggers following operations:");
      this._component1.DoB();
      this._component2.DoC();
    }
  }
}

// Базовый Компонент обеспечивает базовую функциональность хранения
// экземпляра посредника внутри объектов компонентов.
class BaseComponent {
  IMediator _mediator;

  // НЕ ОБЯЗАТЕЛЬНЫЙ
  BaseComponent([IMediator mediator = null]) {
    this._mediator = mediator;
  }

  void SetMediator(IMediator mediator) {
    this._mediator = mediator;
  }
}

// Конкретные Компоненты реализуют различную функциональность. Они не
// зависят от других компонентов. Они также не зависят от каких-либо
// конкретных классов посредников.
class Component1 extends BaseComponent {

  void DoA() {
    print("Component 1 does A.");

    this._mediator.Notify(this, "A");
  }

  void DoB() {
    print("Component 1 does B.");

    this._mediator.Notify(this, "B");
  }
}

class Component2 extends BaseComponent {

  void DoC() {
    print("Component 2 does C.");

    this._mediator.Notify(this, "C");
  }

  void DoD() {
    print("Component 2 does D.");

    this._mediator.Notify(this, "D");
  }
}

void main() {
  // Клиентский код.
  Component1 component1 = Component1();
  Component2 component2 = Component2();
  new ConcreteMediator(component1, component2);

  print("Client triggets operation A.");
  component1.DoA();

  print('');

  print("Client triggers operation D.");
  component2.DoD();
}
