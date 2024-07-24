import 'package:panzer_maid/tinybox.dart';
// import 'package:panzer_maid/tinybox/shell.dart';

void main(List<String> terminalArgs) async {
  // panzerMaidShell(terminalArgs);
  TinyBoxFacade someTinyBox = TinyBoxFacade(
      terminalArgs: ['touch', 'test_file.txt'], command: 'ls -lha');
  print(await someTinyBox.unixBox());
}
