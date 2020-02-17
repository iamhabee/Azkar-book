import 'dart:async';
import 'dart:convert';
import 'package:Azkar_Book/models/AdhkarModel.dart';
import 'package:flutter/services.dart';


class AzkarService {

  static String filePath = '/data/azkar.txt';

  static Future<String> getAzkarContent(String text_path) async {
    String text;
    try {
      text = await rootBundle.loadString(text_path);
      // print(text);
    } catch (e) {
      text = "Couldn't read file";
    }
    return text;
  }


  static Future<List<Adhkar>> getAdhkarList({q}) async {
    String azhkarFileContent = await rootBundle.loadString('assets/data/adhkars.json');
    List collection = json.decode(azhkarFileContent);
    Iterable<Adhkar> _adhkars = collection.map((json) => Adhkar.fromJson(json));
    print(_adhkars);
    if (q != null && q.isNotEmpty) {
      _adhkars = _adhkars.where((adhkar) => adhkar.name.toLowerCase().contains(q));
    }
    return _adhkars.toList();
  }

}