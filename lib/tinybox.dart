import 'package:panzer_maid/tinybox/shell.dart';
import 'package:panzer_maid/tinybox/utils.dart';
import 'package:panzer_maid/unix/unixutils.dart';

class TinyBoxFacede {
  List<String> terminalArgs = [];

  TinyBoxFacede();

  Future<int> exec() async {
    if (terminalArgs.isEmpty) stdint('fail');
    return panzerMaidShell(this.terminalArgs);
  }

  Future<int> flawless() {
    if (terminalArgs.isEmpty) stdint('fail');
    return flawlessExec(this.terminalArgs);
  }

  Future<int> tinybox() {
    if (terminalArgs.isEmpty) stdint('fail');
    return tinyBoxExec(this.terminalArgs, this.terminalArgs[0]);
  }
}
