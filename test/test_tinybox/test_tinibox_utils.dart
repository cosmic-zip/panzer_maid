import 'package:panzer_maid/tinybox/utils.dart';
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

  group('importDatabaseJson', () {
    test('Import db.json and check the contents', () async {
      var db = importDatabaseJson();

      var mocked_out = {
        "name": "nuke.hd",
        "command": "shred -vzn 7 @@device",
        "description":
            "Securely deletes and overwrites the contents of a device seven times",
      };

      expect(await db['general'][0], equals(mocked_out));
    });
    test('Import db.json and search for invalid fields', () async {
      var db = importDatabaseJson();
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
