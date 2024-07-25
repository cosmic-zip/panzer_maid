import 'package:panzer_maid/tinybox.dart';
import 'package:test/test.dart';

void test_unix_utils() {
  group('TinyBoxFacade', () {
    test('executes touch command with arguments', () async {
      TinyBoxFacade someTinyBox = TinyBoxFacade(
        terminalArgs: ['touch', 'test_file.txt'],
      );
      int result = await someTinyBox.unixBox();
      expect(result, equals(0));
    });

    test('executes ls command with fake arguments', () async {
      TinyBoxFacade someTinyBox = TinyBoxFacade(
        terminalArgs: ['ls', '-lha'],
      );
      int result = await someTinyBox.unixBox();
      expect(result, equals(1));
    });

    test('executes ls command with FAKE arguments', () async {
      TinyBoxFacade someTinyBox = TinyBoxFacade(
        terminalArgs: ['ls', '-lha'],
      );
      int result = await someTinyBox.unixBox();
      expect(result, equals(1));
    });

    test('executes greep command with arguments', () async {
      TinyBoxFacade someTinyBox = TinyBoxFacade(
        terminalArgs: [
          'grep',
          '--file',
          'test/artifacts/grepme.txt',
          '--partern',
          'こんにちは'
        ],
      );
      int result = await someTinyBox.unixBox();
      expect(result, equals(0));
    });

    test('executes cat command with arguments', () async {
      TinyBoxFacade someTinyBox = TinyBoxFacade(
        terminalArgs: ['cat', 'test/artifacts/grepme.txt'],
      );
      int result = await someTinyBox.unixBox();
      expect(result, equals(0));
    });

    test('executes systeminfo command with arguments', () async {
      TinyBoxFacade someTinyBox = TinyBoxFacade(
        terminalArgs: ['systeminfo'],
      );
      int result = await someTinyBox.unixBox();
      expect(result, equals(0));
    });
  });
}
