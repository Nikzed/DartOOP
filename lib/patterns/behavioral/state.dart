class Context {
  // Ссылка на текущее состояние Контекста.
  State _state;

  Context(State state) {
    transitionTo(state);
  }

  // Контекст позволяет изменять объект Состояния во время выполнения.
  void transitionTo(State state) {
    print('Context: Transition to ${state.runtimeType}.');
    _state = state;
    _state.setContext(this);
  }

  // Контекст делегирует часть своего поведения текущему объекту cостояния.
  void request1() {
    _state.handle1();
  }

  void request2() {
    _state.handle2();
  }
}

// Базовый класс Состояния объявляет методы, которые должны реализовать все
// Конкретные Состояния, а также предоставляет обратную ссылку на объект
// Контекст, связанный с Состоянием. Эта обратная ссылка может
// использоваться Состояниями для передачи Контекста другому Состоянию.
abstract class State {
  Context _context;

  void setContext(Context context) {
    _context = context;
  }

  void handle1();

  void handle2();
}

// Конкретные Состояния реализуют различные модели поведения, связанные с
// состоянием Контекста.
class ConcreteStateA extends State {
  // Context _context;

  @override
  void handle1() {
    print('ConcreteStateA handles request1.');
    print('ConcreteStateA wants to change the state of the context.');
    _context.transitionTo(ConcreteStateB());
  }

  @override
  void handle2() {
    print('ConcreteStateA handles request2.');
  }
}

class ConcreteStateB extends State {
  @override
  void handle1() {
    print('ConcreteStateB handles request1.');
  }

  @override
  void handle2() {
    print('ConcreteStateB handles request2.');
    print('ConcreteStateB wants to change the state of the context.');
    _context.transitionTo(ConcreteStateA());
  }
}

void main() {
  // Клиентский код.
  var context = Context(ConcreteStateA());
  context.request1();
  context.request2();
}
