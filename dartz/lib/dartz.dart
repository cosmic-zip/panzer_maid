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

void puts(name, {String color = "none"}) {
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

  print("\u001b[1m$emoji $name\u001b[0m");
}
