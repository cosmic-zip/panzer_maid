import 'package:panzer_maid/tinybox/panzer_utils.dart';

import 'dart:math';
import 'dart:io';

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

Map<String, int> windowSize() {
  return {
    "width": stdout.terminalColumns,
    "heidth": stdout.terminalLines,
  };
}

void headerBoxed(String message) async {
  await internalExec("clear");
  int size = stdout.terminalColumns;
  if (message.length >= size) {
    message = message.substring(0, 64);
  }

  var fmt = ("█" * size) +
      ("\n" * 2) +
      (" " * (size ~/ 2 - message.length ~/ 2)) +
      (message) +
      ("\n" * 2) +
      ("█" * size) +
      ("\n" * 2);
  puts(fmt, color: 'green');
}
