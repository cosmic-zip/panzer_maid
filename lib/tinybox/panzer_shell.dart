import 'package:panzer_maid/tinybox/panzer_manual.dart';
import 'package:panzer_maid/tinybox/panzer_tui.dart';
import 'package:panzer_maid/tinybox/panzer_utils.dart';

/// The core function of panzer_maid suite, this function
/// should call all other functions
Future<int> panzerMaidShell(List terminalArgs) async {
  if (terminalArgs.isEmpty) return 255;
  var option = terminalArgs[0];
  switch (option) {
    case '--help' || '-h':
      userManual(terminalArgs);
      return 0;
    case '--welcome' || '-w':
      panzerMaidWelcome();
      return 0;
    default:
      return 255;
  }
}
