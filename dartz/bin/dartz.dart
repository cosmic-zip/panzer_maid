import 'package:dartz/dartz.dart' as dartz;

void main(List<String> arguments) {
  var log = dartz.logger("test", "in", "out");
  var mog = dartz.puts("Hello puts!", color: "black");
}
