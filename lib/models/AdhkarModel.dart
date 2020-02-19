class Adhkar {
  final String name;
  final String code;
  final String audio_path;
  final String text_path;
  final int type;
  final List play_group;

  Adhkar(this.name, this.code, this.audio_path, this.text_path, this.play_group, this.type);


  Adhkar.fromJson(Map<String, dynamic> json) :
    name = json['name'],
    code = json['code'],
    audio_path = json['audio_path'],
    text_path = json['text_path'],
    type = json['type'],
    play_group = json['play_group'];

}