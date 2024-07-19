import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:panzer_maid/tinybox/panzer_tui.dart';

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

String puts(text,
    {String color = "none",
    String bgcolor = "none",
    String style = "bold",
    bool output = true}) {
  if (text == "") {
    return "";
  }

  var reset = '\x1B[0m';

  const colorCodes = {
    'black': '\x1B[30m',
    'red': '\x1B[31m',
    'green': '\x1B[32m',
    'yellow': '\x1B[33m',
    'blue': '\x1B[34m',
    'magenta': '\x1B[35m',
    'cyan': '\x1B[36m',
    'white': '\x1B[37m',
    'gray': '\x1B[90m',
  };

  const background_color = {
    'bgBlack': '\x1B[40m',
    'bgRed': '\x1B[41m',
    'bgGreen': '\x1B[42m',
    'bgYellow': '\x1B[43m',
    'bgBlue': '\x1B[44m',
    'bgMagenta': '\x1B[45m',
    'bgCyan': '\x1B[46m',
    'bgWhite': '\x1B[47m',
  };

  const font_style = {
    'bold': '\x1B[1m',
    'dim': '\x1B[2m',
    'italic': '\x1B[3m',
    'underline': '\x1B[4m',
    'inverse': '\x1B[7m',
    'hidden': '\x1B[8m',
    'strikethrough': '\x1B[9m',
  };

  var formated_text = text;

  if (colorCodes[color] != null) {
    formated_text = "${colorCodes[color]}$formated_text";
  }

  if (background_color[bgcolor] != null) {
    formated_text = "${background_color[bgcolor]}$formated_text";
  }

  if (font_style[style] != null) {
    print(font_style[style]);
    formated_text = "\x1B[1m$formated_text";
  }

  formated_text = formated_text + reset;

  if (output == true) {
    print(formated_text);
  }
  return formated_text;
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

String searchKeyValue(List terminalArgs, {String key = ""}) {
  if (terminalArgs.length < 2) return "";
  if (key == "") key = terminalArgs[1];

  for (final key in terminalArgs) {
    var key_index = terminalArgs.indexOf(key);
    if (key_index + 1 >= terminalArgs.length) {
      return "";
    }
    // Filter and Return
    var parsed = key.replaceAll('-', '');
    if (parsed == key) return terminalArgs[key_index + 1];
  }
  return "";
}

String queryMaker(List<String> terminalArgs) {
  if (terminalArgs.length == 0) return "nothing";

  final db = importBank();
  for (final item in db["general"]) {
    if (item["name"] != terminalArgs[0]) {
      continue;
    }

    if (terminalArgs.length == 1) {
      return item["command"];
    }

    for (final key in terminalArgs) {
      if (key.startsWith("--") || key.startsWith("-")) {
        var key_index = terminalArgs.indexOf(key);
        if (key_index + 1 >= terminalArgs.length) {
          return "Index overflow";
        }
        // Filter and Return
        var value = terminalArgs[key_index + 1];
        var parsed_key = key.replaceAll('-', '');
        return item["command"].replaceAll("@@$parsed_key", value);
      }
    }
  }

  return "nothing";
}

Future<int> rawExec(
    List<String> terminalArgs, Completer<void> completer) async {
  if (terminalArgs.isEmpty) {
    completer.complete();
    return 255;
  }

  var query = queryMaker(terminalArgs);
  var out = await Process.run("/bin/sh", ['-c', query]);
  puts("\r\rExec result :: Eexecuted", color: "green", style: 'bold');
  stdout.write(out.stdout);

  if (out.stderr != "") {
    puts("Exec output: Error", color: "red", style: 'bold');
    stdout.write(out.stderr);
  }
  completer.complete();
  return out.exitCode;
}

// Dont use with panzerRunner function!
Future<int> internalExec(String command) async {
  var out = await Process.run("/bin/sh", ['-c', command]);
  stdout.write(out.stdout);
  return out.exitCode;
}

Future<int> panzerRunner(List<String> terminalArgs) async {
  var completer = Completer<void>();
  var seconds = 0;
  Timer.periodic(Duration(seconds: 1), (timer) {
    if (completer.isCompleted) {
      timer.cancel();
      if (seconds > 2) {
        drawLine('magenta');
      }
    } else {
      seconds += 1;
      if (seconds > 2) {
        stdout.write("\r\rWait for it to finish: ${seconds}s");
      }
    }
  });

  return await rawExec(terminalArgs, completer);
}
