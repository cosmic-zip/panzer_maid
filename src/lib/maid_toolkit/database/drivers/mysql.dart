import 'dart:convert';
import 'dart:io';
import 'package:mysql1/mysql1.dart';
import 'package:path/path.dart' as path;

Future<void> clonerDriverForMysql(
  String host,
  int port,
  String user,
  String db,
  String password,
) async {
  final settings = ConnectionSettings(
    host: host,
    port: port,
    user: user,
    db: db,
    password: password,
  );

  final conn = await MySqlConnection.connect(settings);

  final filePath = path.join(Directory.current.path, 'backup.json');

  try {
    final tableResults = await conn.query('SHOW TABLES');
    final List<String> tableNames = [
      for (var row in tableResults) row[0] as String
    ];

    dynamic backupData = {};
    if (File(filePath).existsSync()) {
      final existingData = await File(filePath).readAsString();
      backupData = jsonDecode(existingData);
    }

    for (final tableName in tableNames) {
      if (!backupData.containsKey(tableName)) {
        final results = await conn.query('SELECT * FROM `$tableName`');
        final List<Map<String, dynamic>> tableData = [
          for (var row in results) row.fields
        ];
        backupData[tableName] = tableData;

        final jsonString = jsonEncode(backupData);
        await File(filePath).writeAsString(jsonString);
        print('Data for table "$tableName" backed up successfully.');
      }
    }

    print('Backup completed. All tables have been processed.');
  } catch (e) {
    print('Error: $e');
  } finally {
    await conn.close();
  }
}
