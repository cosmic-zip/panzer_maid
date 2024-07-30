import 'dart:io';

Future<Map<String, String>> parser(String path) async {
  final file = File(path);
  String contents = await file.readAsString();
  Map<String, String> values = {};
  var lines = contents.split('\n');
  for (final line in lines) {
    print(line);
  }
  return values;
}
