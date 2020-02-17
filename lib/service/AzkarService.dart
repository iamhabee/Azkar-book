import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class AzkarService {

  static String filePath = '/data/azkar.txt';

  static Future<String> getAzkarContent(String code) async {
    String text;
    try {
      text = await rootBundle.loadString('assets/data/${code}.txt');
      // print(text);
    } catch (e) {
      text = "Couldn't read file";
    }
    return text;
  }

}