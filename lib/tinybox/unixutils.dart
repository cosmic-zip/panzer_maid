import 'dart:io';
import 'dart:async';
import 'dart:typed_data';

import 'package:panzer_maid/tinybox/utils.dart';

Future<int> touch(List<String> terminalArgs) async {
  try {
    if (terminalArgs.length < 2) return stdint('fail');
    final file = File(terminalArgs[1]);
    await file.writeAsString('');
    return stdint('ok');
  } catch (e) {
    return stdint('error');
  }
}

Future<int> cat(List<String> terminalArgs) async {
  try {
    if (terminalArgs.length < 2) return stdint('fail');

    final file = File(terminalArgs[1]);
    String contents = await file.readAsString();
    print(contents);
    return stdint('ok');
  } catch (e) {
    print('An error occurred: $e');
    return stdint('error');
  }
}

Future<int> grep(List<String> terminalArgs) async {
  if (terminalArgs.length <= 2) return stdint('fail');

  String filePath = searchKeyValue(terminalArgs, key: 'file');
  String pattern = searchKeyValue(terminalArgs, key: 'pattern');

  final file = File(filePath);
  List<String> matchedLines = [];

  try {
    List<String> lines = await file.readAsLines();
    for (String line in lines) {
      if (line.contains(pattern)) {
        matchedLines.add(line);
      }
    }
  } catch (e) {
    print('An error occurred: $e');
    return stdint('error');
  }

  for (final item in matchedLines) {
    print(item);
  }
  return stdint('ok');
}

Future<int> ping(List<String> terminalArgs) async {
  if (terminalArgs.length <= 2) {
    return stdint('fail');
  }

  String address = terminalArgs[1];

  try {
    final Stopwatch stopwatch = Stopwatch()..start();
    final List<InternetAddress> result = await InternetAddress.lookup(address);
    stopwatch.stop();

    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      puts('$address successful. Latency: ${stopwatch.elapsedMilliseconds} ms',
          color: 'white');
      return stdint('ok');
    } else {
      puts('Ping to $address failed.', color: 'red');
      return stdint('fail');
    }
  } catch (e) {
    puts('An error occurred: $e', color: 'red');
    return stdint('error');
  }
}

Future<int> mkdir(List<String> terminalArgs) async {
  if (terminalArgs.length <= 2) {
    return stdint('fail');
  }

  String path = terminalArgs[1];

  if (path == '') path = './';
  final directory = Directory(path);

  try {
    if (await directory.exists()) {
      print('Directory already exists.');
      return stdint('ok');
    } else {
      await directory.create(recursive: true);
      print('Directory created successfully.');
      return stdint('fail');
    }
  } catch (e) {
    print('An error occurred: $e');
    return stdint('error');
  }
}

Future<int> rm(List<String> terminalArgs) async {
  if (terminalArgs.length <= 2) {
    return stdint('fail');
  }

  String path = terminalArgs[1];
  if (path == '') path = './';

  final fileSystemEntity = FileSystemEntity.typeSync(path);

  try {
    if (fileSystemEntity == FileSystemEntityType.directory) {
      final directory = Directory(path);
      if (await directory.exists()) {
        await directory.delete(recursive: true);
        return stdint('ok');
      }
      return stdint('fail');
    }

    if (fileSystemEntity == FileSystemEntityType.file) {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
        return stdint('ok');
      }
      return stdint('fail');
    }
    return stdint('fail');
  } catch (e) {
    return stdint('error');
  }
}

Future<int> tree(List<String> terminalArgs, {int depth = 0}) async {
  try {
    String paths = "./";

    var len = terminalArgs.length;
    switch (len) {
      case 0:
        return stdint('fail');
      case 2:
        paths = terminalArgs[1];
      case 3:
        {
          paths = searchKeyValue(terminalArgs, key: 'path');
          depth = int.parse(searchKeyValue(terminalArgs, key: 'depth'));
        }

      default:
        return stdint('fail');
    }

    final directory = Directory(paths);

    if (!directory.existsSync()) {
      print('Directory does not exist.');
      return stdint('fail');
    }

    final entities = directory.listSync();

    for (var entity in entities) {
      final name = entity.uri.pathSegments.last;
      final prefix =
          depth > 0 ? '  ' * depth : ''; // Only add indentation if depth > 0

      if (entity is Directory) {
        print('$prefix$name/');
        if (depth > 0) {
          tree(terminalArgs, depth: depth + 1);
        }
      } else {
        print('$prefix$name');
      }
    }

    return stdint('ok');
  } catch (e) {
    print('An error occurred: $e');
    return stdint('error');
  }
}

Future<int> ls(List<String> terminalArgs) async {
  if (terminalArgs.length == 1) {
    return tree(terminalArgs);
  }
  return stdint('fail');
}

Future<int> deviceZero(List<String> terminalArgs) async {
  try {
    String filePath = searchKeyValue(terminalArgs, key: 'filePath');
    String size = searchKeyValue(terminalArgs, key: 'size');
    int count = int.parse(searchKeyValue(terminalArgs, key: 'count'));

    int dataSize;
    switch (size) {
      case 'B':
        dataSize = 1;
        break;
      case 'M':
        dataSize = 1024 * 1024;
        break;
      case 'G':
        dataSize = 1024 * 1024 * 1024;
        break;
      case 'T':
        dataSize = 1024 * 1024 * 1024 * 1024;
        break;
      default:
        return stdint('fail');
    }

    Uint8List data = Uint8List(dataSize * count);
    await File(filePath).writeAsBytes(data, mode: FileMode.writeOnly);
    return stdint('ok');
  } catch (e) {
    return stdint('error');
  }
}

Future<int> systeminfo(args) async {
  final os = Platform.operatingSystem;
  final osVersion = Platform.operatingSystemVersion;
  final dartVersion = Platform.version;
  final numberOfProcessors = Platform.numberOfProcessors.toString();
  final executable = Platform.executable;
  final resolvedExecutable = Platform.resolvedExecutable;
  final script = Platform.script.toString();
  final environment = Platform.environment.toString();

  print('''
    'Operating System': $os,
    'OS Version': $osVersion,
    'Dart Version': $dartVersion,
    'Number of Processors': $numberOfProcessors,
    'Executable': $executable,
    'Resolved Executable': $resolvedExecutable,
    'Script': $script,
    'Environment Variables': $environment
  ''');

  return stdint('ok');
}

/// Execute tinybox uni like commands
Future<int> unixBoxExec(List<String> terminalArgs, String option) async {
  final Map tinyBoxCommands = {
    'touch': (terminalArgs) => touch(terminalArgs),
    'cat': (terminalArgs) => cat(terminalArgs),
    'grep': (terminalArgs) => grep(terminalArgs),
    'ping': (terminalArgs) => ping(terminalArgs),
    'mkdir': (terminalArgs) => mkdir(terminalArgs),
    'rm': (terminalArgs) => rm(terminalArgs),
    'tree': (terminalArgs) => tree(terminalArgs),
    'ls': (terminalArgs) => ls(terminalArgs),
    'deviceZero': (terminalArgs) => deviceZero(terminalArgs),
    'systeminfo': (terminalArgs) => systeminfo(terminalArgs),
  };

  if (tinyBoxCommands.containsKey(option) == true) {
    return await tinyBoxCommands[option]!(terminalArgs);
  }
  return stdint('fail');
}
