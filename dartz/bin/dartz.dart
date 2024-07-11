import 'package:dartz/dartz.dart' as dartz;

void main(List<String> arguments) async {
  var log = dartz.logger("test", "in", "out");
  var mog = dartz.puts("Hello puts!", color: "black");

  Map<String, dynamic> db = await dartz.import_bank();
  print(db["view"] + db["map"]);
  print(arguments);
}
