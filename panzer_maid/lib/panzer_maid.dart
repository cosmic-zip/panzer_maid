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

Map<String, dynamic> importBank() {
  try {
    final file = File('../db/db.json');
    String contents = file.readAsStringSync();
    Map<String, dynamic> json = jsonDecode(contents);
    return json;
  } catch (e) {
    print(e); // Using print instead of puts, assuming puts was a typo
    return jsonDecode('{"error": "error"}'); // Returning a valid JSON structure
  }
}

String queryMaker(List<String> terminal_args) {
  if (terminal_args.length < 2) {
    return "invalid";
  }

  final db = importBank();
  var module_name = terminal_args[1];

  for (final item in db["general"]) {
    print(item);
  }

  return "valid";
}
