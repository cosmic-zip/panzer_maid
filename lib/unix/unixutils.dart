import 'dart:io';
import 'dart:async';

import 'package:panzer_maid/tinybox/utils.dart';

Future<int> touch(String file) async {
  try {
    final file = File('example.txt');
    await file.writeAsString('');
    return stdint('ok');
  } catch (e) {
    return stdint('error');
  }
}

Future<String> cat(String filePath) async {
  try {
    final file = File(filePath);
    String contents = await file.readAsString();
    print(contents);
    return contents;
  } catch (e) {
    print('An error occurred: $e');
    return '';
  }
}

Future<List<String>> grep(String filePath, String pattern) async {
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
  }

  for (final item in matchedLines) {
    print(item);
  }
  return matchedLines;
}

Future<int> ping(String address) async {
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

Future<int> mkdir(String path) async {
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

Future<int> rm(String path) async {
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

int tree(String path, {int depth = 0}) {
  final directory = Directory(path);

  try {
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
          tree(entity.path, depth: depth + 1);
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

int ls(path) {
  return tree(path, depth: 0);
}

//DONE touch cat grep ping mkdir rm tree ls
// /dev/zero /dev/random ip dd
