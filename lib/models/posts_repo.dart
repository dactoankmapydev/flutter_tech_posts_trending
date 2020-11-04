class PostsRepo {
  String name;
  String link;
  String tags;
  bool bookmarked;

  PostsRepo({
    this.name,
    this.link,
    this.tags,
    this.bookmarked,
  });

  PostsRepo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        link = json['link'],
        tags = json['tags'],
        bookmarked = json['bookmarked'];

  static List<PostsRepo> parseRepoList(map) {
    var list = map['data'] as List;
    return list.map((repo) => PostsRepo.fromJson(repo)).toList();
  }
}
