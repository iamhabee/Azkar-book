import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;



class AudioFileDowloader {

  AudioFileDowloader(this.url, this.path) {
    // downloadFromUrlToFile();
  }

  final String url;
  final File path;
  

  Future downloadFromUrlToFile() async {
      // var file = new File('${(await getTemporaryDirectory()).path}/'+current_play_group_code+'.mp3');
    if (!(await path.exists())) {
      // print('File do not exist');
      print('Downloader Out: '+url);
      print('Path Downdownloader: '+path.toString());
      try {
        http.Response req = await http.Client().get(Uri.parse(url));
        if (req.statusCode == 200) {
          // var file = new File('${(await getTemporaryDirectory()).path}/'+current_play_group_code+'.mp3');
          path.writeAsBytes(req.bodyBytes);
          return {
            "byte": req.bodyBytes, "length": req.contentLength
          };
        } else {
          throw Exception('Failed to load audio');
        }
      } catch (e) {
        print("Downloader Error: "+e.toString());
      }
      
    }
  }

  Stream getDownloadStatus() => Stream.fromFuture(downloadFromUrlToFile());

  // Stream getByteCount() => getDownloadStatus().listen((onData) => StreamController);
}