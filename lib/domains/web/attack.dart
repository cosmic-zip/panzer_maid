import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> lookupItemsOnDomain(
    String domain, String folderFile, String fileFile) async {
  try {
    // Read folder names from file
    List<String> folderNames = await _readNamesFromFile(folderFile);

    // Read file names from file
    List<String> fileNames = await _readNamesFromFile(fileFile);

    // Check if both lists are empty
    if (folderNames.isEmpty && fileNames.isEmpty) {
      print('No folder or file names found in the files.');
      return;
    }

    // Lookup folders and files on the domain
    await _lookupFolders(domain, folderNames);
    await _lookupFiles(domain, fileNames);
  } catch (e) {
    print('Error: $e');
  }
}

Future<List<String>> _readNamesFromFile(String filePath) async {
  File file = File(filePath);
  List<String> names = [];

  if (await file.exists()) {
    names = await file.readAsLines();
    names.removeWhere((name) => name.trim().isEmpty);
  } else {
    print('File $filePath does not exist.');
  }

  return names;
}

Future<void> _lookupFolders(String domain, List<String> folderNames) async {
  for (var folderName in folderNames) {
    final url = Uri.https(domain, folderName);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('Folder "$folderName" exists on $domain');
    } else {
      print('Folder "$folderName" does not exist on $domain');
    }
  }
}

Future<void> _lookupFiles(String domain, List<String> fileNames) async {
  for (var fileName in fileNames) {
    final url = Uri.https(domain, fileName);
    final response =
        await http.head(url); // Use HEAD request for checking file existence

    if (response.statusCode == 200) {
      print('File "$fileName" exists on $domain');
    } else {
      print('File "$fileName" does not exist on $domain');
    }
  }
}

// void main() {
//   final domain = 'example.com'; // Replace with your domain
//   final folderFile =
//       'folder_names.txt'; // Replace with your folder names file path
//   final fileFile = 'file_names.txt'; // Replace with your file names file path

//   lookupItemsOnDomain(domain, folderFile, fileFile);
// }
