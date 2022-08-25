class FeedBackModel {
  String? title;
  String? description;

  FeedBackModel({
    this.title,
    this.description,
  });
  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };

  FeedBackModel.fromJson(Map<String, dynamic> json) {
    title = json['title']! as String;
    description = json['description']! as String;
  }
}
