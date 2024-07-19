import 'package:panzer_maid/tinybox/panzer_tui.dart';
import 'package:panzer_maid/tinybox/panzer_utils.dart';

void userManual({String module = 'all', bool exec = false}) {
  var db = importBank();

  void putsItem(Map<String, dynamic> item) {
    if (item.isEmpty) {
      return;
    }

    puts("Name: ${item["name"]}", color: 'magenta', style: 'bold');
    if (exec)
      puts("Exec build: ${item["command"]}", color: 'white', style: 'bold');
    puts("Description: ${item["description"]}", color: 'white');
  }

  if (module == 'all') {
    for (final item in db['general']) {
      putsItem(item);
    }
    return;
  }

  for (final item in db['general']) {
    if (item['name'] == module) putsItem(item);
  }

  drawLine('magenta');
}
