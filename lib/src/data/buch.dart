import 'rubric.dart';

class Buch {
  final String id;
  final String title;
  final int hymnCount;
  final List<Rubric> rubrics;

  Buch(this.id, this.title, this.hymnCount, this.rubrics);

  bool hymnExists(int nummer) => nummer >= 1 && nummer <= hymnCount;

  Buch.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        hymnCount = json['hymnCount'],
        rubrics = (json['rubrics'] as List).map((i) => Rubric.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'hymnCount': hymnCount,
        'rubrics': rubrics,
      };
}
