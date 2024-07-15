import 'dart:io';
import 'dart:convert';

bool logger(name, origin, output) {
  var json = {
    "name": name,
    "datetime": DateTime.now(),
    "origin": origin,
    "output": output
  };

  print(json);
  return true;
}

void puts(text, {String color = "none"}) {
  const color_emojis = {
    "purple": "🟣",
    "red": "🔴",
    "green": "🟢",
    "yellow": "🟡",
    "blue": "🔵",
    "orange": "🟠",
    "white": "⚪",
    "black": "⚫",
  };
  String emoji = color_emojis[color] ?? "";

  print("\u001b[1m$emoji $text\u001b[0m");
}

dynamic import_bank() async {
  try {
    final file = File('../db/db.json');
    String contents = await file.readAsString();
    Map<String, dynamic> json = jsonDecode(contents);
    return json;
  } catch (e) {
    puts(e, color: "red");
    return jsonDecode("error");
  }
}

String query_maker(String terminal_args) {
  var db = import_bank();

  var module_name = terminal_args[1];

  return "";
}
