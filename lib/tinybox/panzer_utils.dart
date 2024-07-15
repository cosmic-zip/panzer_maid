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
    final file = File('db/db.json');
    String contents = file.readAsStringSync();
    Map<String, dynamic> json = jsonDecode(contents);
    return json;
  } catch (e) {
    print(e); // Using print instead of puts, assuming puts was a typo
    return jsonDecode('{"error": "error"}'); // Returning a valid JSON structure
  }
}

String queryMaker(List<String> terminal_args) {
  if (terminal_args.length == 2) {
    return "invalid";
  }

  final db = importBank();
  // const pattern = r"\s*@@(\w+)\s*";

  for (final item in db["general"]) {
    if (item["name"] != terminal_args[0]) {
      continue;
    }

    if (terminal_args.length == 1) {
      return item["command"];
    }

    String cmd = item["command"];

    for (final key in terminal_args) {
      if (key.startsWith("--") || key.startsWith("-")) {
        var key_index = terminal_args.indexOf(key);
        if (key_index + 1 >= terminal_args.length) {
          puts(
              "Index out of range while searching for an value for the key: $key",
              color: "red");
          return "Index out of range";
        }
        var value = terminal_args[key_index + 1];
        var parsed_key = key.replaceAll('-', '');
        cmd = cmd.replaceAll("@@$parsed_key", value);
      }
    }

    return cmd;
  }

  return "out";
}
