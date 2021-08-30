import 'dart:io';

import 'dart:math';

class Originator
{
  // Для удобства состояние создателя хранится внутри одной переменной.
  String _state;

  Originator(String state)
  {
    this._state = state;
    print("Originator: My initial state is: " + state);
  }

  // Бизнес-логика Создателя может повлиять на его внутреннее состояние.
  // Поэтому клиент должен выполнить резервное копирование состояния с
  // помощью метода save перед запуском методов бизнес-логики.
  void DoSomething()
  {
    print("Originator: I'm doing something important.");
    this._state = this.GenerateRandomString(30);
    print('Originator: and my state has changed to: $_state');
  }

  String GenerateRandomString([int length = 10])
  {
  String allowedSymbols = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String result = '';

  while (length > 0)
  {
    result += allowedSymbols[Random().nextInt(allowedSymbols.length)];

  sleep(Duration(milliseconds:50));


  length--;
  }

  return result;
  }

  // Сохраняет текущее состояние внутри снимка.
  IMemento save()
  {
    return ConcreteMemento(this._state);
  }

  // Восстанавливает состояние Создателя из объекта снимка.
  void Restore(IMemento memento)
  {
    if (!(memento is ConcreteMemento))
    {
      throw new Exception("Unknown memento class " + memento.toString());
    }

    this._state = memento.GetState();
    print('Originator: My state has changed to: $_state');
  }
}

abstract class IMemento
{
String GetName();

String GetState();

DateTime GetDate();
}

// Конкретный снимок содержит инфраструктуру для хранения состояния
// Создателя.
class ConcreteMemento implements IMemento
{
  String _state;

  DateTime _date;

  ConcreteMemento(String state)
{
  _state = state;
  _date = DateTime.now();
}

// Создатель использует этот метод, когда восстанавливает своё
// состояние.
@override
  String GetState()
{
  return this._state;
}

// Остальные методы используются Опекуном для отображения метаданных.
@override
  String GetName()
{
  return '$_date / (${_state.substring(0, 9)})...';
}

@override
  DateTime GetDate()
{
  return this._date;
}
}

// Опекун не зависит от класса Конкретного Снимка. Таким образом, он не
// имеет доступа к состоянию создателя, хранящемуся внутри снимка. Он
// работает со всеми снимками через базовый интерфейс Снимка.
class Caretaker
{
  List<IMemento> _mementos = [];

  Originator _originator;

  Caretaker(Originator originator)
  {
    _originator = originator;
  }

  void Backup()
  {
    print("\nCaretaker: Saving Originator's state...");
    _mementos.add(_originator.save());
  }

  void Undo()
  {
    if (_mementos.isEmpty)
    {
      print('NO ELEMENTS FOUNDED!');
      return;
    }

    var memento = _mementos.last;
    this._mementos.remove(memento);

    print("Caretaker: Restoring state to: " + memento.GetName());

    try
    {
      this._originator.Restore(memento);
    }
    catch (Exception)
    {
      this.Undo();
    }
  }

  void ShowHistory()
  {
    print("Caretaker: Here's the list of mementos:");

    _mementos.forEach((element) {print(element.GetName());});
  }
}

void main()
{
// Клиентский код.
Originator originator = Originator('Super-duper-super-puper-super.');
Caretaker caretaker = Caretaker(originator);

caretaker.Backup();
originator.DoSomething();

caretaker.Backup();
originator.DoSomething();

caretaker.Backup();
originator.DoSomething();

print('');
caretaker.ShowHistory();

print("\nClient: Now, let's rollback!\n");
caretaker.Undo();

print('\n\nClient: Once more!\n');
caretaker.Undo();

print('\n\nClient: !QOnce more!\n');
caretaker.Undo();

print('\n\nClient: !!QWOnce more!\n');
caretaker.Undo();
print('');
}
