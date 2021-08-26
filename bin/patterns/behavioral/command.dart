abstract class Command {
  void Execute();
}

class SimpleCommand implements Command {
  String _payload;

  SimpleCommand(this._payload);

  @override
  void Execute() {
    print(
        'SimpleCommand: See, I can do simple things like printing (${_payload})');
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

  // Initialize commands.
  void SetOnStart(Command command) {
    _onStart = command;
  }

  void SetOnFinish(Command command) {
    _onFinish = command;
  }

  // The Invoker does not depend on concrete command or receiver classes.
  // The Invoker passes a request to a receiver indirectly, by executing a
  // command.
  void DoSomethingImportant() {
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
  Invoker invoker = Invoker();
  invoker.SetOnStart(SimpleCommand('Say Hi!'));
  Receiver receiver = Receiver();
  invoker.SetOnFinish(
      ComplexCommand(receiver, 'Send email', 'Save report'));

  invoker.DoSomethingImportant();
}
