import 'dart:io';
import 'dart:async';
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
  if (text == "") {
    text = "Nothing to see here, check if your input are right.";
  }

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

String queryMaker(List<String> terminalArgs) {
  if (terminalArgs.length == 0) {
    return "invalid";
  }

  final db = importBank();
  // const pattern = r"\s*@@(\w+)\s*";

  for (final item in db["general"]) {
    if (item["name"] != terminalArgs[0]) {
      continue;
    }

    if (terminalArgs.length == 1) {
      return item["command"];
    }

    String cmd = item["command"];

    for (final key in terminalArgs) {
      if (key.startsWith("--") || key.startsWith("-")) {
        var key_index = terminalArgs.indexOf(key);
        if (key_index + 1 >= terminalArgs.length) {
          puts(
              "Index out of range while searching for an value for the key: $key",
              color: "red");
          return "Index out of range";
        }
        var value = terminalArgs[key_index + 1];
        var parsed_key = key.replaceAll('-', '');
        cmd = cmd.replaceAll("@@$parsed_key", value);
      }
    }

    return cmd;
  }

  return "out";
}

Future<int> rawExec(
    List<String> terminalArgs, Completer<void> completer) async {
  var out = await Process.run("/bin/sh", ['-c', "sleep 3"]);
  stdout.write(out.stdout);

  if (out.stderr != "") {
    puts("Error", color: "red");
    stdout.write(out.stderr);
  }
  completer.complete();
  return out.exitCode;
}

Future<int> panzerRunner(List<String> terminalArgs) async {
  var completer = Completer<void>();

  var counter = 0;
  Timer.periodic(Duration(milliseconds: 1000), (timer) {
    if (completer.isCompleted) {
      print('Done');
      timer.cancel();
    } else {
      counter = counter + 1;
      stdout.write('\rThread ainda está em execução $counter');
    }
  });

  return await rawExec(terminalArgs, completer);
}
