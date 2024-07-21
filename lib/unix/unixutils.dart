import 'dart:io';
import 'dart:async';

import 'package:panzer_maid/tinybox/utils.dart';

Future<int> touch(String file) async {
  try {
    final file = File('example.txt');
    await file.writeAsString('');
    return 0;
  } catch (e) {
    return 1;
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

Future<void> ping(String address) async {
  try {
    final Stopwatch stopwatch = Stopwatch()..start();
    final List<InternetAddress> result = await InternetAddress.lookup(address);
    stopwatch.stop();

    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      puts('$address successful. Latency: ${stopwatch.elapsedMilliseconds} ms',
          color: 'white');
    } else {
      puts('Ping to $address failed.', color: 'red');
    }
  } catch (e) {
    puts('An error occurred: $e', color: 'red');
  }
}

Future<void> mkdir(String path) async {
  if (path == '') path = './';
  final directory = Directory(path);

  try {
    if (await directory.exists()) {
      print('Directory already exists.');
    } else {
      await directory.create(recursive: true);
      print('Directory created successfully.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}



//DONE touch cat grep ping mkdir
// ls rm /dev/zero /dev/random ip
