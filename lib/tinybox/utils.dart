import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:panzer_maid/tinybox/consts.dart';

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

/// Options fail → 0; error → 255, ok → 0
int stdint(re) {
  switch (re) {
    case 'fail':
      return 1;
    case 'error':
      return 255;
    default:
      return 0;
  }
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

Map<String, dynamic> importDatabaseJson() {
  try {
    final file = File(DATABASE);
    String contents = file.readAsStringSync();
    return jsonDecode(contents);
  } catch (e) {
    return jsonDecode('{"error": "Error at import db"}');
  }
}

String searchKeyValue(List terminalArgs, {String key = ""}) {
  if (terminalArgs.length < 2) return "";
  if (key == "") key = terminalArgs[1];

  for (final item in terminalArgs) {
    var key_index = terminalArgs.indexOf(item);
    if (key_index + 1 > terminalArgs.length) return "";
    if (item == key) return terminalArgs[key_index + 1];
  }
  return "";
}

String queryMaker(List<String> terminalArgs) {
  if (terminalArgs.length == 0) return "nothing";

  final db = importDatabaseJson();
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

Future<int> flawlessExec(terminalArgs) async {
  puts('Reminder: Use command string inside quotes, like "command --foo bar"\n',
      style: 'bold', color: 'yellow');
  if (terminalArgs.length >= 2) {
    var out = await Process.run("/bin/sh", ['-c', terminalArgs[1]]);
    stdout.write(out.stdout);
    return out.exitCode;
  }
  return 255;
}

Future<int> terminalShellExec(
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

Future<int> panzerRunner(List<String> terminalArgs) async {
  var completer = Completer<void>();
  var seconds = 0;
  Timer.periodic(Duration(seconds: 1), (timer) {
    if (completer.isCompleted) {
      timer.cancel();
    } else {
      seconds += 1;
      if (seconds > 2) {
        stdout.write("\r\rWait for it to finish: ${seconds}s");
      }
    }
  });

  return await terminalShellExec(terminalArgs, completer);
}
