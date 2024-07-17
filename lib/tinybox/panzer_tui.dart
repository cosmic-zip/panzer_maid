import 'dart:math';

String tuiNumbPairs() {
  String str = "";
  int count = 0;
  String tmp = "";
  for (int i = 0; i < 20; i++) {
    var r = Random().nextInt(10);
    tmp = tmp + "$r";
    if (count % 2 == 0 && tmp.length > 1) {
      str = str + " " + tmp;
      tmp = "";
    }
  }
  return str;
}
