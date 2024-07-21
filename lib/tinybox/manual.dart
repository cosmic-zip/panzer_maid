import 'package:panzer_maid/tinybox/consts.dart';
import 'package:panzer_maid/tinybox/tui.dart';
import 'package:panzer_maid/tinybox/utils.dart';

/// Give meaning to common [arg] words if possible
String argumentMeanings(String arg) {
  var out = STANDARD_ARGUMENTS[arg] ?? 'Meaning not found';
  puts("\t--$arg: $out", color: 'cyan');
  return out;
}

void putsItem(Map<String, dynamic> item) {
  if (item.isEmpty) return;
  puts("Name: ${item["name"]}", color: 'magenta', style: 'bold');

  var string_args = [];
  for (final String arg in item['command'].split(" ")) {
    if (arg.contains("@@") && !string_args.contains(arg)) {
      var parsed = arg.replaceAll("@", "");
      parsed = parsed.replaceAll(":", "");
      string_args.add(parsed);
      argumentMeanings(parsed);
    }
  }
  puts("Description: ${item["description"]}", color: 'white');
  print(" ");
}

/// User manual for db.json execs and native execs.
void userManual(List<String> terminalArgs) {
  var db = importBank();
  var module = 'all';

  if (terminalArgs.length >= 2) module = terminalArgs[1];

  if (module == 'all') {
    for (final item in db['general']) {
      putsItem(item);
    }
    drawLine('magenta');
  } else {
    for (final item in db['general']) {
      if (item['name'] == module) putsItem(item);
    }
  }
}
