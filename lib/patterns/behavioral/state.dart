class Context {
  // Ссылка на текущее состояние Контекста.
  State _state = null;

  Context(State state) {
    this.TransitionTo(state);
  }

  // Контекст позволяет изменять объект Состояния во время выполнения.
  void TransitionTo(State state) {
    print('Context: Transition to ${state.runtimeType}.');
    _state = state;
    _state.SetContext(this);
  }

  // Контекст делегирует часть своего поведения текущему объекту
  // Состояния.
  void Request1() {
    _state.Handle1();
  }

  void Request2() {
    _state.Handle2();
  }
}

// Базовый класс Состояния объявляет методы, которые должны реализовать все
// Конкретные Состояния, а также предоставляет обратную ссылку на объект
// Контекст, связанный с Состоянием. Эта обратная ссылка может
// использоваться Состояниями для передачи Контекста другому Состоянию.
abstract class State {
  Context _context;

  void SetContext(Context context) {
    _context = context;
  }

  void Handle1();

  void Handle2();
}

// Конкретные Состояния реализуют различные модели поведения, связанные с
// состоянием Контекста.
class ConcreteStateA extends State {
  // Context _context;

  void Handle1() {
    print("ConcreteStateA handles request1.");
    print("ConcreteStateA wants to change the state of the context.");
    this._context.TransitionTo(new ConcreteStateB());
  }

  void Handle2() {
    print("ConcreteStateA handles request2.");
  }
}

class ConcreteStateB extends State {

  void Handle1() {
    print("ConcreteStateB handles request1.");
  }

  void Handle2() {
    print("ConcreteStateB handles request2.");
    print("ConcreteStateB wants to change the state of the context.");
    this._context.TransitionTo(new ConcreteStateA());
  }
}

void main() {
  // Клиентский код.
  var context = new Context(new ConcreteStateA());
  context.Request1();
  context.Request2();
}
