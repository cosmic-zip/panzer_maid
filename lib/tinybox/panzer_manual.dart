import 'package:panzer_maid/tinybox/panzer_tui.dart';
import 'package:panzer_maid/tinybox/panzer_utils.dart';

/// Give meaning to common [arg] words if possible
String argumentMeanings(String arg) {
  var argumentMeanings = {
    'dns': 'set domain name',
    'target': 'set IP or domain name',
    'ip': 'set IP address',
    'path': 'set file path',
    'file': 'set file location',
    'wordlist': 'path to wordlist',
    'port': 'set port number',
    'output': 'set output file',
    'protocol': 'set communication protocol',
    'timeout': 'set timeout duration',
    'wait': 'set delay duration',
    'verbose': 'enable verbose mode',
    'recursive': 'enable recursive mode',
    'overwrite': 'overwrite existing files',
    'url': 'taget complete URL path with http/https',
  };

  var out = argumentMeanings[arg] ?? 'Meaning not found';
  puts("\t--$arg: $out", color: 'cyan');
  return out;
}

void putsItem(Map<String, dynamic> item) {
  if (item.isEmpty) return;

  puts("Name: ${item["name"]}", color: 'magenta', style: 'bold');
  if (true)
    puts("Exec build: ${item["command"]}", color: 'white', style: 'bold');

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
}

/// User manual for db.json execs and native execs.
void userManual(List<String> terminalArgs) {
  var db = importBank();
  var module = 'all';
  if (terminalArgs.length >= 2) module = terminalArgs[1];
  drawLine('magenta');
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
