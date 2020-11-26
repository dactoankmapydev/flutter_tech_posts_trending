class PostRepo {
  String name;
  String link;
  String tag;

  PostRepo({
    this.name,
    this.link,
    this.tag,
  });

  PostRepo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        link = json['link'],
        tag = json['tag'];

  static List<PostRepo> parseRepoList(map) {
    var list = map['data'] as List;
    return list.map((repo) => PostRepo.fromJson(repo)).toList();
  }
}