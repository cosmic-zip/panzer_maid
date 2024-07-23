import 'package:panzer_maid/tinybox/shell.dart';
import 'package:panzer_maid/tinybox/utils.dart';
import 'package:panzer_maid/tinybox/unixutils.dart';

class TinyBoxFacade {
  List<String> terminalArgs = [];
  String command = '';

  TinyBoxFacade();

  Future<int> exec() async {
    if (terminalArgs.isEmpty) stdint('fail');
    return panzerMaidShell(this.terminalArgs);
  }

  Future<int> flawless() {
    if (terminalArgs.isEmpty) stdint('fail');
    if (!command.isEmpty) flawlessExec(["--flaw", command]); 
    return flawlessExec(this.terminalArgs);
  }

  Future<int> unixBox() {
    if (terminalArgs.isEmpty) stdint('fail');
    return unixBoxExec(this.terminalArgs, this.terminalArgs[0]);
  }

  Future<int> pkgManager() {
    return pkg();
  }
}
