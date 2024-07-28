import 'package:panzer_maid/maid_shell.dart';
import 'package:test/test.dart';

void test_unix_utils() {
  group('MaidShell', () {
    test('executes touch command with arguments', () async {
      MaidShell someMaidShell = MaidShell(
        terminalArgs: ['touch', 'test_file.txt'],
      );
      int result = await someMaidShell.tinybox();
      expect(result, equals(0));
    });

    test('executes ls command with fake arguments', () async {
      MaidShell someMaidShell = MaidShell(
        terminalArgs: ['ls', '-lha'],
      );
      int result = await someMaidShell.tinybox();
      expect(result, equals(1));
    });

    test('executes ls command with FAKE arguments', () async {
      MaidShell someMaidShell = MaidShell(
        terminalArgs: ['ls', '-lha'],
      );
      int result = await someMaidShell.tinybox();
      expect(result, equals(1));
    });

    test('executes greep command with arguments', () async {
      MaidShell someMaidShell = MaidShell(
        terminalArgs: [
          'grep',
          '--file',
          'test/artifacts/grepme.txt',
          '--partern',
          'こんにちは'
        ],
      );
      int result = await someMaidShell.tinybox();
      expect(result, equals(0));
    });

    test('executes cat command with arguments', () async {
      MaidShell someMaidShell = MaidShell(
        terminalArgs: ['cat', 'test/artifacts/grepme.txt'],
      );
      int result = await someMaidShell.tinybox();
      expect(result, equals(0));
    });

    test('executes systeminfo command with arguments', () async {
      MaidShell someMaidShell = MaidShell(
        terminalArgs: ['systeminfo'],
      );
      int result = await someMaidShell.tinybox();
      expect(result, equals(0));
    });
  });
}
