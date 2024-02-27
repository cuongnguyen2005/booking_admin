import 'package:intl/intl.dart';

class NumberFormatUnity {
  static priceFormat(int price) {
    String priceFomart = NumberFormat.decimalPattern().format(price);
    return priceFomart;
  }
}
