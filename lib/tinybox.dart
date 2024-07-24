import 'package:panzer_maid/tinybox/shell.dart';
import 'package:panzer_maid/tinybox/utils.dart';
import 'package:panzer_maid/tinybox/unixutils.dart';

class TinyBoxFacade {
  static const List<String> emptyTerminalArgs = [];
  List<String> terminalArgs = [];
  String command = '';

  TinyBoxFacade({this.terminalArgs = emptyTerminalArgs, this.command = ""});

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
    return unixBoxExec(this.terminalArgs, this.terminalArgs[0]);
  }

  Future<int> pkgManager() {
    return pkg();
  }
}
