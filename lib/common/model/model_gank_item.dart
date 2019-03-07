class GankItem {
  String itemId;
  String createdAt;
  String desc;
  List<String> images;
  String publishedAt;
  String source;
  String type;
  String url;
  String who;
  String category;
  bool isTitle = false;

  GankItem.title(this.isTitle, this.category);

  GankItem.fromJson(Map<String, dynamic> json, {String category}) {
    this.itemId = json['itemId'] ?? json['_id'] ?? json['ganhuo_id'];
    this.category = category;
    setField(json);
  }

  void setField(Map<String, dynamic> json) {
    this.createdAt = json['createdAt'];
    this.desc = json['desc'] ?? '';
    this.images = json['images']?.map<String>((image)=> image as String)?.toList() ?? [];
    this.publishedAt = json['publishedAt'];
    this.source = json['source'];
    this.type = json['type'];
    this.url = json['url'];
    this.who = json['who'] ?? "github";
  }

  Map<String, dynamic> toJsonMap() {
    Map<String, dynamic> map = new Map();
    if (itemId != null) {
      map["itemId"] = itemId;
      map["createdAt"] = createdAt;
      map["desc"] = desc;
      map["images"] = images;
      map["publishedAt"] = publishedAt;
      map["source"] = source;
      map["type"] = type;
      map["url"] = url;
      map["who"] = who;
      map["category"] = category;
    }
    return map;
  }

}