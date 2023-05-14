import 'chorsatz_international_list.dart';

class Hymn {
  final String buchId;
  final int nummer;
  final int rubricIndex;
  final String title;
  final String text;
  final String copyright;
  final String tonart;
  final String taktart;
  final int pdfPageIndex;
  final int pdfPageCount;
  final String link;

  //data
  final String note;
  final bool isFavorite;
  final int rating;
  final List<DateTime> sungOnList;

  Hymn(this.buchId, this.nummer, this.rubricIndex, this.title, this.text, this.copyright, this.tonart, this.taktart, this.pdfPageIndex,
      this.pdfPageCount, this.link, this.note, this.isFavorite, this.rating, this.sungOnList);

  String getNummerAndTitle() => "$nummer. $title";

  bool containsCopyRight() => text.toLowerCase().contains("urheberrechtlich geschützt");

  bool hasChorsatz() => buchId != "gb" ? false : chorsatzList.contains(nummer);

  bool isInternational() => buchId != "gb" ? false : internationalList.contains(nummer);

  bool hasPdf() => pdfPageCount > 0 && pdfPageIndex >= 0;

  Hymn.fromJson(Map<String, dynamic> json)
      : buchId = json['buchId'],
        nummer = json['nummer'],
        rubricIndex = json['rubricIndex'],
        title = json['title'],
        text = json['text'],
        copyright = json['copyright'],
        tonart = json['tonart'],
        taktart = json['taktart'],
        pdfPageIndex = json['pdfPageIndex'],
        pdfPageCount = json['pdfPageCount'],
        link = json['link'],
        note = json['note'],
        isFavorite = json['isFavorite'],
        rating = json['rating'],
        sungOnList = (json['sungOnList'] as List).map((i) => DateTime.parse(i)).toList();

  Map<String, dynamic> toJson() => {
        'buchId': buchId,
        'nummer': nummer,
        'rubricIndex': rubricIndex,
        'title': title,
        'text': text,
        'copyright': copyright,
        'tonart': tonart,
        'taktart': taktart,
        'pdfPageIndex': pdfPageIndex,
        'pdfPageCount': pdfPageCount,
        'link': link,
        'note': note,
        'isFavorite': isFavorite,
        'rating': rating,
        'sungOnList': sungOnList.map((i) => i.toIso8601String()).toList(),
      };
}
