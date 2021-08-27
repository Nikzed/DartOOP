import 'dart:math';

void main() {
  var basic = Basic();
  var blackJack = BlackJack(basic);
  blackJack.play();
}

abstract class PlayStrategy {
  bool takeCard(int yourCard, int dealerCard);
}

class AlwaysStand implements PlayStrategy {
  @override
  bool takeCard(int yourCard, int dealerCard) {
    return false;
  }
}

class AlwaysTake implements PlayStrategy {
  @override
  bool takeCard(int yourCard, int dealerCard) {
    return true;
  }
}

class Basic implements PlayStrategy {
  @override
  bool takeCard(int yourCard, int dealerCard) {
    if (yourCard > 16) {
      return false;
    } else if (yourCard >= 12 && dealerCard < 7) {
      return false;
    } else {
      return true;
    }
  }
}

class BlackJack {
  int you;
  int dealer;
  final Random _random = Random();
  PlayStrategy strategy;

  BlackJack(PlayStrategy strategy) {
    this.strategy = strategy;
  }

  void play() {
    generate();
    print('your Cards is: $you\n'
        'dealer Card is: $dealer\n'
        'will you take?: ${strategy.takeCard(you, dealer)}');
    dealer += _random.nextInt(11) + 2;
    print('your Cards is: $you\n'
        'dealer Card is: $dealer');
    if (dealer > you) {
      print('LOSE');
    } else {
      print('WIN');
    }
  }

  void generate() {
    dealer = _random.nextInt(11) + 2;
    you = _random.nextInt(11) + _random.nextInt(11) + 4;
  }
}
