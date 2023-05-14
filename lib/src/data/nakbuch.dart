import 'buch.dart';
import 'hymn.dart';

class NAKBuch {
  final List<Buch> buecher;
  final List<Hymn> lieder;

  NAKBuch(this.buecher, this.lieder);

  NAKBuch.fromJson(Map<String, dynamic> json)
      : buecher = (json['buecher'] as List).map((i) => Buch.fromJson(i)).toList(),
        lieder = (json['lieder'] as List).map((i) => Hymn.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'buecher': buecher.map((i) => i.toJson()).toList(),
        'lieder': lieder.map((i) => i.toJson()).toList(),
  };
}
