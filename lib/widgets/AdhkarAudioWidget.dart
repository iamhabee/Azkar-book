import 'dart:io';

import 'package:Azkar_Book/models/AdhkarModel.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;



class AdhkarAudioWidget extends StatefulWidget {
  AdhkarAudioWidget({this.zikiri, this.type});
  final Adhkar zikiri;
  final String type;
  @override
  _AdhkarAudioWidgetState createState() => _AdhkarAudioWidgetState();
}


class _AdhkarAudioWidgetState extends State<AdhkarAudioWidget> {
  AudioPlayer audioPlayer = AudioPlayer();

  String _selectedReciter = 'Toyyib';
  bool isPlaying = false;
  bool playing = false;
  String _url;
  String _indicatorText = 'Click play button to play audio';
  AudioPlayerState audioPlayerState;

  Future loadAsset(String path) async {
    return await rootBundle.load(path);
  }

  play(path) async {
    try {
      setState(() {
        _indicatorText = 'Getting audio file...';
      });
      var req = await http.Client().get(Uri.parse(_url));
      var file = new File('${(await getTemporaryDirectory()).path}/music.mp3');
      file.writeAsBytes(req.bodyBytes);

      print(req.bodyBytes);
      final result = await audioPlayer.play(file.path, isLocal: true);
      // int result = (await audioPlayer.play(widget.audioPath.toString())) as int;
      print('Play Result: '+result.toString());
      if (result == 1) {
        setState(() {
          audioPlayerState = AudioPlayerState.PLAYING;
          _indicatorText = 'Listening to '+widget.zikiri.name+' by '+_selectedReciter;
        });
      }
    } catch (e) {
      print('Play Error '+e.toString());
    }
  }

  resume() async {
    try {
      final result = await audioPlayer.resume();
      if (result == 1) {
        setState(() {
          audioPlayerState = AudioPlayerState.PLAYING;
          _indicatorText = 'Listening to '+widget.zikiri.name+' by '+_selectedReciter;
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
          audioPlayerState = AudioPlayerState.PAUSED;
          _indicatorText = 'Audio paused. Click on play button to play audio';
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
          audioPlayerState = AudioPlayerState.STOPPED;
          _indicatorText = 'Audio Stopped. Click on play button to play audio';
        });
      }
    } catch (e) {
      print('Pause Error: '+e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _url = (widget.type == 'adhkar') ? 'http://wetinsup.000webhostapp.com/adhkar_book/adhkars/audio/'+widget.zikiri.code+'.mp3' : (widget.type == 'lecture') ? '' : '';
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(100.0),
          bottomLeft: Radius.circular(100.0)
        )
      ),
      child: Column(
        children: <Widget>[
          Row(
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
              (audioPlayerState == AudioPlayerState.PLAYING) ? IconButton(
                icon: Icon(
                  Icons.stop, 
                  color: Colors.white,
                ), 
                onPressed: () {
                  stop();
                }
              ) : Padding(padding: const EdgeInsets.all(0.0),),
              IconButton(
                icon: Icon(
                  (audioPlayerState == AudioPlayerState.PLAYING) ? Icons.pause_circle_filled : Icons.play_circle_filled, 
                  color: Colors.white,
                ), 
                onPressed: (){
                  setState(() {
                    (audioPlayerState == AudioPlayerState.PLAYING) ? pause() : (audioPlayerState == AudioPlayerState.PAUSED) ? resume() : play(widget.zikiri.audio_path);
                  });
                }
              )
            ],
          )
          ,
          Text(_indicatorText)
        ]
      ),
    );
  }
}