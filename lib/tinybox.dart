import 'package:panzer_maid/tinybox/shell.dart';
import 'package:panzer_maid/tinybox/utils.dart';
import 'package:panzer_maid/tinybox/unixutils.dart';

class TinyBoxFacade {
  static const List<String> emptyTerminalArgs = [];
  List<String> terminalArgs = [];
  String command = '';

  TinyBoxFacade({this.terminalArgs = emptyTerminalArgs, this.command = ""});

  /// The most simple implementation of panzerMaidShell, use:
  /// shell = TinyBoxFacade(terminalArgs: terminalArgs);
  /// Future<int> output = await shell.exec();
  /// For terminalArgs and List<String> of any size
  Future<int> exec() async {
    if (terminalArgs.isEmpty) return stdint('fail');
    return panzerMaidShell(this.terminalArgs);
  }

  /// Execute an external binary with args like:
  /// shell = TinyBoxFacade(command: "some command --with args");
  /// Future<int> output = await shell.flawless();
  Future<int> flawless() async {
    if (terminalArgs.isEmpty) return stdint('fail');
    if (!command.isEmpty) flawlessExec(["--flaw", command]);
    return flawlessExec(this.terminalArgs);
  }

  /// An rootless replacement for unix/MSDOS command line
  /// Future<int> output = await shell.unixBox();
  Future<int> unixBox() async {
    if (terminalArgs.isEmpty) return stdint('fail');
    return unixBoxExec(this.terminalArgs, this.terminalArgs[0]);
  }

  /// Install depedencies defines in db.json using APT
  Future<int> pkgManager() {
    return pkg();
  }
}
