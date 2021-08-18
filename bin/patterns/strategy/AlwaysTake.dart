import 'PlayStrategy.dart';

class AlwaysTake implements PlayStrategy {
  @override
  bool takeCard(int yourCard, int dealerCard) {
    return true;
  }
}
