class Rubric {
  final String buchId;
  final int index;
  final String title;
  final bool isMain;

  Rubric(this.buchId, this.index, this.title, this.isMain);

  Rubric.fromJson(Map<String, dynamic> json)
      : buchId = json['buchId'],
        index = json['index'],
        title = json['title'],
        isMain = json['isMain'];

  Map<String, dynamic> toJson() => {
    'buchId': buchId,
    'index': index,
    'title': title,
    'isMain': isMain,
  };
}