import 'PlayStrategy.dart';

class AlwaysStand implements PlayStrategy {
  @override
  bool takeCard(int yourCard, int dealerCard) {
    return false;
  }
}
