import 'package:panzer_maid/maid_shell/utils.dart';
import 'bonkers.dart';

Future<int> tinyBox(List<String> terminalArgs, String option) async {
  final Map tinyBoxCommands = {
    'attack.luks': (terminalArgs) => luks_bonkers(terminalArgs),
  };
  return commandOption(tinyBoxCommands, terminalArgs, option);
}
