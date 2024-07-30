import 'dart:io';
import 'package:panzer_maid/maid_shell/utils.dart';

Future<int> luks_bonkers(List<String> terminalArgs) async {
  try {
    String device = searchKeyValue(terminalArgs, key: 'device');

    final file = File('');
    var contents = await file.readAsLines();
    for (final line in contents) {
      var cmd =
          "echo '$line' | cryptsetup open --key-file - /dev/$device encrypted_device";
      var out = await flawlessExec(cmd);
      if (out == 0) {
        puts("Found! key :: $line", color: 'green');
        return out;
      }
    }
  } catch (e) {
    return stdint('error');
  } finally {
    return stdint('ok');
  }
}
