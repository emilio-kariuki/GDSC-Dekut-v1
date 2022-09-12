class FeedBackModel {
  String? description;

  FeedBackModel({
    this.description,
  });
  Map<String, dynamic> toJson() => {
        "description": description,
      };

  FeedBackModel.fromJson(Map<String, dynamic> json) {
    description = json['description']! as String;
  }
}
