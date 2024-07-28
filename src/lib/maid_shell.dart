import 'package:panzer_maid/maid_shell/dos_utils.dart';
import 'package:panzer_maid/maid_shell/shell.dart';
import 'package:panzer_maid/maid_shell/utils.dart';

class MaidShell {
  static const List<String> emptyTerminalArgs = [];
  List<String> terminalArgs = [];
  String command = '';

  MaidShell({this.terminalArgs = emptyTerminalArgs, this.command = ""});

  Future<int> exec() async {
    if (terminalArgs.isEmpty) return stdint('fail');
    return panzerMaidShell(this.terminalArgs);
  }

  Future<int> flawless() async {
    if (terminalArgs.isEmpty) return stdint('fail');
    if (!command.isEmpty) flawlessExec(["--flaw", command]);
    return flawlessExec(this.terminalArgs);
  }

  Future<int> unixBox() async {
    if (terminalArgs.isEmpty) return stdint('fail');
    return unixToDosExec(this.terminalArgs, this.terminalArgs[0]);
  }

  Future<int> pkgManager() {
    return pkg();
  }

  String findKeyPair(String key) {
    return searchKeyValue(terminalArgs, key: key);
  }
}
