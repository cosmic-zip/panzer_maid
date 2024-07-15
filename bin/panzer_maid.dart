import 'package:panzer_maid/tinybox/utils.dart';

void main(List<String> arguments) {
  var log = logger("test", "in", "out");
  var mog = puts("Hello puts!", color: "black");
  Map<String, dynamic> db = importBank();
  print(db["generic"]);
  print(arguments);
  queryMaker(arguments);
}
