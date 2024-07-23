import 'package:panzer_maid/tinybox/manual.dart';
import 'package:panzer_maid/tinybox/status.dart';
import 'package:panzer_maid/tinybox/tui.dart';
import 'package:panzer_maid/tinybox/utils.dart';

Future<int> panzerMaidShell(List<String> terminalArgs) async {
  if (terminalArgs.isEmpty) {
    panzerMaid();
    return 255;
  }
  var option = terminalArgs[0];
  switch (option) {
    case '--help' || '-h':
      return userManual(terminalArgs);
    case '--well' || '-w':
      return panzerMaidWelcome();
    case '--panzer':
      return panzerMaid();
    case '--status':
      return panzerStatus();
    case '--raw':
      return flawlessExec(terminalArgs);
    case '--install-deps':
      return pkg();
    default:
      return await panzerRunner(terminalArgs);
  }
}
