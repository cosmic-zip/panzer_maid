import 'package:panzer_maid/tinybox/panzer_utils.dart';
import 'package:test/test.dart';

void test_tinibox_utils() {
  group('logger', () {
    test('Test logger function', () {
      var log = logger("name", "origin", "output");
      expect(log, equals(true));
    });
  });

  group('Puts', () {
    test('Test pust func with an empty string', () {
      var out = puts("");
      expect(out, "");
    });
    test('Test pust func with an random string (uses bold output by default)',
        () {
      var out = puts("random");
      expect(out, "\x1B[1mrandom\x1B[0m");
    });
    test('Test pust func with an random string with color magenta', () {
      var out = puts("random", color: 'magenta');
      expect(out, "\x1B[1m\x1B[35mrandom\x1B[0m");
    });
  });

  group('importBank', () {
    test('Import db.json and test its contents', () async {
      var db = importBank();

      var mocked_out = {
        "description":
            "Securely deletes and overwrites the contents of a device seven times",
        "name": "nuke.hd",
        "command": "shred -vzn 7 @@device"
      };

      expect(await db['general'][0], equals(mocked_out));
    });
    test('Import db.json and search for invalid fields', () async {
      var db = importBank();

      expect(await db['REEEE'], equals(null));
    });
  });

  group('flawlessExec', () {
    test('prints reminder and exits with 255 for empty arguments', () async {
      var test_string = [];
      expect(await flawlessExec(test_string), equals(255));
    });
    test('Executes ls -lha and returns 0', () async {
      var test_string = ["--raw", "ls -la"];
      expect(await flawlessExec(test_string), equals(0));
    });
  });
  group('searchKeyValue', () {
    test('searchKeyValue given 2 terminal args', () async {
      var args = ['mocked'];
      expect(await searchKeyValue(args), equals(''));
    });
    test('searchKeyValue given an terminal args only', () async {
      var args = ['mocked', '--foo', 'bar'];
      expect(await searchKeyValue(args), equals('bar'));
    });
  });
}
