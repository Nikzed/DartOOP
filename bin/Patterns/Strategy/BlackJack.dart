import 'dart:math';

import 'PlayStrategy.dart';

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
