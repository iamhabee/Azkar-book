import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  Future<File> _localFile(String file_name) async {
    final path = await _localPath;

    return File('$path/' + file_name);
  }

  Future<String> readFileContent(String file_name) async {
    try {
      await writeToFile('azkar.txt', 'I am coming next week for the data');
      final file = await _localFile(file_name);

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future<File> writeToFile(String file_name, String data) async {
    final file = await _localFile(file_name);

    // Write the file
    return file.writeAsString('$data');
  }
}
