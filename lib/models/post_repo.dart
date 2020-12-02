class PostRepo {
  String name;
  String link;
  String tag;
  bool bookmarked;

  PostRepo({
    this.name,
    this.link,
    this.tag,
    this.bookmarked,
  });

  PostRepo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        link = json['link'],
        tag = json['tag'],
        bookmarked = json['bookmarked'];


  static List<PostRepo> parseRepoList(map) {
    var list = map['data'] as List;
    return list.map((post) => PostRepo.fromJson(post)).toList();
  }
}