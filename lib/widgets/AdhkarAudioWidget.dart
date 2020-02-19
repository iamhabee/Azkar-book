import 'dart:io';

import 'package:Azkar_Book/models/AdhkarModel.dart';
import 'package:Azkar_Book/service/AudioFileDowloader.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';



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
  List play_group;
  int total_play_group;
  int current_play_group_index;
  String current_play_group_code;
  AudioFileDowloader audioFileDowloader;
  Duration position;
  Duration duration;

  bool gettingFile = false;

  Future loadAsset(String path) async {
    return await rootBundle.load(path);
  }

  Future loadFileFromUrl() async {
    File file = new File('${(await getTemporaryDirectory()).path}/'+current_play_group_code+'.mp3');
    if (!(await file.exists())) {
      setState(() {
        gettingFile = true;
        _indicatorText = 'Downloading Audio File...';
      });
      http.Response req = await http.Client().get(Uri.parse(_url));
      if (req.statusCode == 200) {
        var file = new File('${(await getTemporaryDirectory()).path}/'+current_play_group_code+'.mp3');
        file.writeAsBytes(req.bodyBytes).whenComplete(() => setState(() => gettingFile = false)).catchError((onError) => print('Moving Error: '+onError.toString()));
      } else {
        setState(() {
          gettingFile = false;
          _indicatorText = 'Unable to load file';
        });
        throw Exception('Failed to load audio');
      }
    }
  }

  void listenToChanges() {
    
    audioPlayer.onPlayerStateChanged.listen((playState) {
      setState(() => audioPlayerState = playState);
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        if ((current_play_group_index + 1) == total_play_group) {
          setState(() { 
            audioPlayerState = AudioPlayerState.COMPLETED;
            _indicatorText = 'Audio completed, Click the play button to repeat';
          });
        } else {
          setState(() {
            stop();
            current_play_group_index = current_play_group_index + 1;
            current_play_group_code = widget.zikiri.play_group[current_play_group_index];
          });
          play();
        }
      });
    });

    audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        audioPlayerState = AudioPlayerState.STOPPED;
        // duration = Duration(seconds: 0);
        // position = Duration(seconds: 0);
      });
    });
    
    audioPlayer.onAudioPositionChanged.listen((Duration  p) {
      print('Current position: $p');
      setState(() => position = p);
    });
  
    audioPlayer.onDurationChanged.listen((Duration d) {
      print('Max duration: $d');
      setState(() => duration = d);
    });
  }

  play() async {
    try {
      var file = new File('${(await getTemporaryDirectory()).path}/'+current_play_group_code+'.mp3');
      // print('Path Play: '+(await file.exists()).toString());
      if (await file.exists()) {
        final result = await audioPlayer.play(file.path, isLocal: true);
        print('Play Result: '+result.toString());
        if (result == 1) {
          setState(() {
            _indicatorText = 'Listening to '+widget.zikiri.name+' by '+_selectedReciter;
            gettingFile = false;
          });
        }
      } else {
        await loadFileFromUrl();
        play();
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
          _indicatorText = 'Audio Stopped. Click on play button to play audio';
        });
      }
    } catch (e) {
      print('Pause Error: '+e.toString());
    }
  }

  seek(direction) async {
    if (direction == 'forward') {
      await audioPlayer.seek(position + Duration(seconds: 30));
    } else if (direction == 'rewind') {
      await audioPlayer.seek(position - Duration(seconds: 30));
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      play_group = widget.zikiri.play_group;
      total_play_group = widget.zikiri.play_group.length;
      current_play_group_index = 0;
      current_play_group_code = play_group[current_play_group_index];
      _url = (widget.type == 'adhkar') ? 'http://wetinsup.000webhostapp.com/adhkar_book/adhkars/audio/'+widget.zikiri.code+'.mp3' : (widget.type == 'lecture') ? '' : '';
    });
    listenToChanges();
    loadFileFromUrl();
  }

  @override
  void dispose() {
    stop();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if ((gettingFile)) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Center(
              child: LinearProgressIndicator(backgroundColor: Colors.blue,)
            ),
            Center(child: Text(_indicatorText)),
          ],
        ),
      );
    } else {
      return Column(
        // crossAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: LinearPercentIndicator(
                    lineHeight: 8.0,
                    percent: (position != null) ? (position.inMilliseconds/1000000).toDouble() : 0.0,
                    progressColor: Colors.white,
                  ),
                ),
                Text(position.toString()),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(_indicatorText)
                  ],
                )
              ),
              (audioPlayerState == AudioPlayerState.PLAYING) ? 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.stop, 
                      color: Colors.white,
                    ), 
                    onPressed: () {
                      stop();
                    }
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.fast_rewind, 
                      color: Colors.white,
                    ),
                    tooltip: 'Back Rewind by 30 Sec',
                    onPressed: () {
                      seek('rewind');
                    }
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.fast_forward, 
                      color: Colors.white,
                    ),
                    tooltip: 'Fast forward by 30 Sec',
                    onPressed: () {
                      seek('forward');
                    }
                  ),
                ],
              ) : Padding(padding: const EdgeInsets.all(0.0),),
              IconButton(
                icon: Icon(
                  (audioPlayerState == AudioPlayerState.PLAYING) ? Icons.pause_circle_filled : Icons.play_circle_filled, 
                  color: Colors.white,
                ), 
                onPressed: (){
                  setState(() {
                    (audioPlayerState == AudioPlayerState.PLAYING) ? pause() : (audioPlayerState == AudioPlayerState.PAUSED) ? resume() : play();
                  });
                }
              )
            ],
          ),
        ]
      );
    }
  }
}