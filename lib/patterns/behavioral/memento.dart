import 'dart:io';
import 'dart:math';

class Originator {
  // Для удобства состояние создателя хранится внутри одной переменной.
  String _state;

  Originator(String state) {
    _state = state;
    print('Originator: My initial state is: ' + state);
  }

  // Бизнес-логика Создателя может повлиять на его внутреннее состояние.
  // Поэтому клиент должен выполнить резервное копирование состояния с
  // помощью метода save перед запуском методов бизнес-логики.
  void doSomething() {
    print("Originator: I'm doing something important.");
    _state = generateRandomString(30);
    print('Originator: and my state has changed to: $_state');
  }

  String generateRandomString([int length = 10]) {
    String allowedSymbols =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String result = '';

    while (length > 0) {
      result += allowedSymbols[Random().nextInt(allowedSymbols.length)];

      // sleep(Duration(milliseconds: 50));

      length--;
    }

    return result;
  }

  // Сохраняет текущее состояние внутри снимка.
  IMemento save() {
    return ConcreteMemento(_state);
  }

  // Восстанавливает состояние Создателя из объекта снимка.
  void restore(IMemento memento) {
    if (!(memento is ConcreteMemento)) {
      throw Exception('Unknown memento class ' + memento.toString());
    }

    _state = memento.getState();
    print('Originator: My state has changed to: $_state');
  }
}

abstract class IMemento {
  String getName();

  String getState();

  DateTime getDate();
}

// Конкретный снимок содержит инфраструктуру для хранения состояния создателя
class ConcreteMemento implements IMemento {
  String _state;

  DateTime _date;

  ConcreteMemento(String state) {
    _state = state;
    _date = DateTime.now();
  }

// Создатель использует этот метод, когда восстанавливает своё
// состояние.
  @override
  String getState() {
    return _state;
  }

// Остальные методы используются Опекуном для отображения метаданных.
  @override
  String getName() {
    return '$_date / (${_state.substring(0, 9)})...';
  }

  @override
  DateTime getDate() {
    return _date;
  }
}

// Опекун не зависит от класса Конкретного Снимка. Таким образом, он не
// имеет доступа к состоянию создателя, хранящемуся внутри снимка. Он
// работает со всеми снимками через базовый интерфейс Снимка.
class Caretaker {
  List<IMemento> _mementos = [];

  Originator _originator;

  Caretaker(Originator originator) {
    _originator = originator;
  }

  void backup() {
    print('\nCaretaker: Saving Originator\'s state...');
    _mementos.add(_originator.save());
  }

  void undo() {
    if (_mementos.isEmpty) {
      print('NO ELEMENTS FOUNDED!');
      return;
    }

    var memento = _mementos.last;
    _mementos.remove(memento);

    print('Caretaker: Restoring state to: ' + memento.getName());

    try {
      _originator.restore(memento);
    } catch (Exception) {
      undo();
    }
  }

  void showHistory() {
    print("Caretaker: Here's the list of mementos:");

    _mementos.forEach((element) {
      print(element.getName());
    });
  }
}

void main() {
// Клиентский код.
  Originator originator = Originator('Super-duper-super-puper-super.');
  Caretaker caretaker = Caretaker(originator);

  caretaker.backup();
  originator.doSomething();

  caretaker.backup();
  originator.doSomething();

  caretaker.backup();
  originator.doSomething();

  print('');
  caretaker.showHistory();

  print("\nClient: Now, let's rollback!\n");
  caretaker.undo();

  print('\n\nClient: Once more!\n');
  caretaker.undo();

  print('\n\nClient: !Once more!\n');
  caretaker.undo();

  print('\n\nClient: !!ONCE!! more!\n');
  caretaker.undo();
  print('');
}
