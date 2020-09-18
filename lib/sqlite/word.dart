
class Word {
  int id;
  String word;

  Word({this.id, this.word});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'id': id,
      'word': word
    };

    return map;
  } 

  Word.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    word = map['word'];
  }

}