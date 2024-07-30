import 'package:panzer_maid/maid_toolkit/web/attack.dart';
import 'package:test/test.dart';

void test_maid_toolkit_utils() {
  group('flawlessExecWithouSnowflake', () {
    // This exec the depencies
    test('Test dns_scanner with invalid dns', () async {
      var test_string = ["--dns", "invalid dns name"];
      expect(await dns_scanner(test_string), equals(0));
    });
  });
}
