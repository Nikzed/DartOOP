import 'PlayStrategy.dart';

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
