import 'package:panzer_maid/tinybox/panzer_manual.dart';
import 'package:panzer_maid/tinybox/panzer_tui.dart';
import 'package:panzer_maid/tinybox/panzer_utils.dart';

/// Well that the shell function, this should be async
Future<int> panzerMaidShell(List terminalArgs) async {
  var option = terminalArgs[0];
  switch (option) {
    case '--help' || '-h':
      userManual();
      return 0;
    case '--welcome' || '-w':
      panzerMaidWelcome();
      return 0;
  }
}
