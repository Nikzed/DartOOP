import 'Basic.dart';
import 'BlackJack.dart';

void main() {
  var basic = Basic();
  var blackJack = BlackJack(basic);
  blackJack.play();
}
