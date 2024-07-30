import 'package:panzer_maid/snowflake/parser.dart';
import 'package:test/test.dart';

void test_snowflake_script() {
  group('flawlessExecWithouSnowflake', () {
    test('Test snowflake', () async {
      var test_string = "test/artifacts/grepme.txt";
      expect(await parser(test_string), equals({}));
    });
  });
}
