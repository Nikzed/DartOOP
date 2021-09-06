// ОБРАБАТЫВАЕТ ЗАПРОС ПОСЛЕДОВАТЕЛЬНО
// ПО ЦЕПОЧКЕ ОБРАБОТЧИКОВ
//
// суть в том, что каждый класс хранит
// ссылку на следующий при выполнении последовательности

abstract class Handler {
  Handler setNext(Handler handler);

  Object Handle(Object request);
}

abstract class AbstractHandler implements Handler {
  Handler _nextHandler;

  @override
  Handler setNext(Handler handler) => _nextHandler = handler;

  @override
  Object Handle(Object request) {
    if (_nextHandler != null) return _nextHandler.Handle(request);
    return null;
  }
}

class MonkeyHandler extends AbstractHandler {
  @override
  Object Handle(Object request) {
    if ((request as String) == 'Banana') {
      return 'Monkey: I\'ll eat the ${request.toString()}.\n';
    }
    return super.Handle(request);
  }
}

class SquirrelHandler extends AbstractHandler {
  @override
  Object Handle(Object request) {
    if (request.toString() == 'Nut') {
      return 'Squirrel: I\'ll eat the ${request.toString()}.\n';
    }
    return super.Handle(request);
  }
}

class DogHandler extends AbstractHandler {
  @override
  Object Handle(Object request) {
    if (request.toString() == 'MeatBall')
      return 'Dog: I\'ll eat the ${request.toString()}.\n';
    return super.Handle(request);
  }
}

class Client {
  // Обычно клиентский код приспособлен для работы с единственным
  // обработчиком. В большинстве случаев клиенту даже неизвестно, что этот
  // обработчик является частью цепочки.
  static void clientCode(AbstractHandler handler) {
    for (var food in {'Nut', 'Banana', 'Cup of coffee'}) {
      print('Client: Who wants a $food?');

      var result = handler.Handle(food);

      if (result != null) {
        print('   $result');
      } else {
        print('   $food was left untouched.');
      }
    }
  }
}

void main() {
  var monkey = MonkeyHandler();
  var squirrel = SquirrelHandler();
  var dog = DogHandler();

  monkey.setNext(squirrel).setNext(dog);

  // Клиент должен иметь возможность отправлять запрос любому
  // обработчику, а не только первому в цепочке.
  print('Chain: Monkey > Squirrel > Dog\n');
  Client.clientCode(monkey);
  print('');

  print('Subchain: Squirrel > Dog\n');
  Client.clientCode(squirrel);
}
