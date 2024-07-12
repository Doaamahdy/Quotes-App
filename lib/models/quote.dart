class Quote {
  int? id;
  String? text;
  String? author;
  int? isFavourite;

  Quote(
      {this.id,
      required this.text,
      required this.author,
      this.isFavourite = 0});

  Quote.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    author = json['author'];
    id = json['id'];
    isFavourite = json['isFavourite'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['text'] = text;
    data['author'] = author;
    data['id'] = id;
    data['isFavourite'] = isFavourite;
    return data;
  }
}
