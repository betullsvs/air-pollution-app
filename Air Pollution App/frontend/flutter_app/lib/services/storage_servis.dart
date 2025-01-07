import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageService {
  Future<void> writeToAppSpecificStorage(
      String fileName, String content) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(content);
  }

  Future<String?> readFromAppSpecificStorage(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    if (await file.exists()) {
      return await file.readAsString();
    }
    return null;
  }
}
