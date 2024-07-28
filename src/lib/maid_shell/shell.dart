import 'package:panzer_maid/maid_shell/manual.dart';
import 'package:panzer_maid/maid_shell/utils.dart';

Future<int> panzerMaidShell(List<String> terminalArgs) async {
  if (terminalArgs.isEmpty) {
    panzerStatus();
    return 255;
  }
  var option = terminalArgs[0];
  switch (option) {
    case '--help' || '-h':
      return userManual(terminalArgs);
    case '--well' || '-w':
      return panzerMaidWelcome();
    case '--panzer':
      return panzerStatus();
    case '--status':
      return maidStatus();
    case '--flaw':
      if (terminalArgs.length < 2) return stdint('fail');
      return flawlessExec(terminalArgs[1]);
    case '--install-deps':
      return pkg();
    default:
      return await panzerRunner(terminalArgs);
  }
}
