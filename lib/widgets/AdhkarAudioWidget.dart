import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';



class AdhkarAudioWidget extends StatefulWidget {
  AdhkarAudioWidget({this.audioPath});
  final String audioPath;
  @override
  _AdhkarAudioWidgetState createState() => _AdhkarAudioWidgetState();
}


class _AdhkarAudioWidgetState extends State<AdhkarAudioWidget> {
  AudioPlayer audioPlayer = AudioPlayer();

  String _selectedReciter = 'Toyyib';
  bool isPlaying = false;
  bool playing = false;

  Future loadAsset(String path) async {
    return await rootBundle.load(path);
  }

  play(path) async {
    try {
      final file = new File('${(await getTemporaryDirectory()).path}/music.mp3');
      await file.writeAsBytes((await loadAsset(path)).buffer.asUint8List());
      final result = await audioPlayer.play(file.path, isLocal: true);
      // int result = (await audioPlayer.play(widget.audioPath.toString())) as int;
      print('Play Result: '+result.toString());
      if (result == 1) {
        setState(() {
          isPlaying = true;
          playing = true;
        });
      }
    } catch (e) {
      print('Play Error '+e.toString());
    }
  }

  pause() async {
    try {
      int result = await audioPlayer.pause();
      print('Pause Result: '+result.toString());
      if (result == 1) {
        setState(() {
          isPlaying = false;
        });
      }
    } catch (e) {
      print('Pause Error: '+e.toString());
    }
  }

  stop() async {
    try {
      int result = await audioPlayer.stop();
      print('Stop Result: '+result.toString());
      if (result == 1) {
        setState(() {
          isPlaying = false;
          playing = false;
        });
      }
    } catch (e) {
      print('Pause Error: '+e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(100.0),
          topLeft: Radius.circular(100.0)
        )
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Reciter:',),
                DropdownButton<String>(
                  value: _selectedReciter,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                    color: Colors.deepPurple
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.white,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      _selectedReciter = newValue;
                    });
                  },
                  items: <String>['Toyyib', 'Amir Mubarak', 'Uncle Ismail', 'Uncle Nurein']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
                )
              ],
            )
          ),
          IconButton(
            icon: Icon(
              (isPlaying) ? Icons.pause_circle_filled : Icons.play_circle_filled, 
              color: Colors.white,
            ), 
            onPressed: (){
              setState(() {
                isPlaying = (isPlaying) ? pause() : play(widget.audioPath);
              });
            }
          ),
          IconButton(
            icon: Icon(
              Icons.stop, 
              color: Colors.white,
            ), 
            onPressed: () {
              stop();
            }
          )
        ],
      )
    );
  }
}