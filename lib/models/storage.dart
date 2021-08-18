import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import './configuaration.dart';

class Storage {
  // static Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();

  //   return directory.path;
  // }

  // static Future<File> get _localFile async {
  //   final path = await _localPath;
  //   return File('$path/2048_boards.txt');
  // }

  static Future<void> loadAsset(String path) async {
    Config.tasksListData = await rootBundle.loadString(path);
  }

  // static Future<List<String>> readData() async {
  //   try {
  //     final file = ;
  //     final content = await file.readAsLines();
  //     return content;
  //   } catch (e) {
  //     return [];
  //   }
  // }

  // static Future<File> writeData(List<String> lines) async {
  //   final file = await _localFile;
  //   String content = lines.join('\n');
  //   return file.writeAsString(content);
  // }
}
