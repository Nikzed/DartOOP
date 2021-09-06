// паттерн используется когда нужно откладывать выполнение команд,
// выстраивать их в очереди, а также хранить историю и делать отмену.

abstract class Command {
  void Execute();
}

class SimpleCommand implements Command {
  String _payload;

  SimpleCommand(this._payload);

  @override
  void Execute() {
    print('SimpleCommand: I can do simple things like printing ($_payload)');
  }
}

class ComplexCommand implements Command {
  Receiver _receiver;

  String _a;

  String _b;

  ComplexCommand(this._receiver, this._a, this._b);

  @override
  void Execute() {
    print('ComplexCommand: Complex stuff should be done by a receiver object.');
    _receiver.DoSomething(_a);
    _receiver.DoSomethingElse(_b);
  }
}

class Receiver {
  void DoSomething(String a) {
    print('Receiver: Working on ($a.)');
  }

  void DoSomethingElse(String b) {
    print('Receiver: Also working on ($b.)');
  }
}

class Invoker {
  Command _onStart;

  Command _onFinish;

  void setOnStart(Command command) {
    _onStart = command;
  }

  void setOnFinish(Command command) {
    _onFinish = command;
  }

  // Invoker не зависит от конкретной команды или классов получателя.
  // Invoker передает запрос получателю косвенно, выполняя команду косвенно
  void doSomethingImportant() {
    print('Invoker: Does anybody want something done before I begin?');
    if (_onStart is Command) {
      _onStart.Execute();
    }

    print('Invoker: ...doing something really important...');

    print('Invoker: Does anybody want something done after I finish?');
    if (_onFinish is Command) {
      _onFinish.Execute();
    }
  }
}

void main() {
  // создали инвокер
  Invoker invoker = Invoker();

  invoker.setOnStart(SimpleCommand('I PRINTED SOMETHING!'));
  Receiver receiver = Receiver();
  invoker.setOnFinish(ComplexCommand(receiver, 'Send email', 'Save report'));

  invoker.doSomethingImportant();
}
