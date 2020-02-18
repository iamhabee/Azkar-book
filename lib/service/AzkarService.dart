import 'dart:async';
import 'dart:convert';
import 'package:Azkar_Book/models/AdhkarModel.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class AzkarService {

  static String filePath = '/data/azkar.txt';

  static Future<String> getAzkarContent(String code) async {
    String text;
    try {
      String _url = 'http://wetinsup.000webhostapp.com/adhkar_book/adhkars/text/'+code+'.txt';
      http.Response response = await http.get(_url);
      text = response.body;
    } catch (e) {
      text = "Couldn't read file";
    }
    return text;
  }


  static Future<List<Adhkar>> getAdhkarList({q}) async {
    // String azhkarFileContent = await rootBundle.loadString('assets/data/adhkars.json');
    http.Response response = await http.get('http://wetinsup.000webhostapp.com/adhkar_book/adhkars/adhkars.json');
    List collection = json.decode(response.body);
    Iterable<Adhkar> _adhkars = collection.map((json) => Adhkar.fromJson(json));
    print(_adhkars);
    if (q != null && q.isNotEmpty) {
      _adhkars = _adhkars.where((adhkar) => adhkar.name.toLowerCase().contains(q));
    }
    return _adhkars.toList();
  }

}