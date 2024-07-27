import 'package:panzer_maid/tinybox/utils.dart';

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
    "height": stdout.terminalLines,
  };
}

int headerBoxed(String message, {String symbol = "█"}) {
  int size = stdout.terminalColumns;

  if (message.length >= size) {
    message = message.substring(0, 64);
  }

  puts(symbol * size, color: 'magenta', style: 'bold');
  print(("\n" + " " * (size ~/ 2 - message.length ~/ 2)) +
      (puts(message, color: 'magenta', style: 'bold', output: false)) +
      "\n");
  puts(symbol * size, color: 'magenta', style: 'bold', output: true) +
      ("\n" * 2);
  return stdint('ok');
}

void drawLine(String color) {
  int size = stdout.terminalColumns;
  puts("█" * size, color: color);
}

int panzerMaidWelcome() {
  int size = stdout.terminalColumns;
  var msg = '''
  ┏━━━┓━━━━━━━━━━━━━━━━━━━━━┏━┓┏━┓━━━━━━━━━┏┓
  ┃┏━┓┃━━━━━━━━━━━━━━━━━━━━━┃┃┗┛┃┃━━━━━━━━━┃┃
  ┃┗━┛┃┏━━┓━┏━┓━┏━━━┓┏━━┓┏━┓┃┏┓┏┓┃┏━━┓━┏┓┏━┛┃
  ┃┏━━┛┗━┓┃━┃┏┓┓┣━━┃┃┃┏┓┃┃┏┛┃┃┃┃┃┃┗━┓┃━┣┫┃┏┓┃
  ┃┃━━━┃┗┛┗┓┃┃┃┃┃┃━━┫┃┃━┫┃┃━┃┃┃┃┃┃┃┗┛┗┓┃┃┃┗┛┃
  ┗┛━━━┗━━━┛┗┛┗┛┗━━━┛┗━━┛┗┛━┗┛┗┛┗┛┗━━━┛┗┛┗━━┛
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''';
  puts("█" * size, color: "magenta");
  for (final line in msg.split("\n")) {
    var out = puts((" " * (size ~/ 2 - line.length ~/ 2) + line),
        color: "magenta", output: false);
    stdout.write(out);
  }
  puts("█" * size + ("\n" * 2), color: "magenta");
  return stdint('ok');
}

void textBoxed() {
  var table = {
    100: "┏",
    110: "┓",
    120: "┗",
    130: "┛",
    140: "┳",
    150: "┻",
    160: "┃",
    170: "━",
    180: "━",
    190: "╋",
    200: "┣",
    210: "┫",
  };

  var test = (table[100]! + (table[170]! * 10) + table[110]!) +
      ("\n" + table[160]! + "Some text " + table[160]!) +
      ("\n" + table[200]! + (table[180]! * 10) + table[210]!) +
      ("\n" + table[120]! + (table[180]! * 10) + table[130]!);

  print(test);
}
