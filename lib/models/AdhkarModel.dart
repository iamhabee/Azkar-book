class Adhkar {
  final String name;
  final String code;

  Adhkar(this.name, this.code);


  Adhkar.fromJson(Map<String, dynamic> json) :
    name = json['name'], code = json['code'];

}