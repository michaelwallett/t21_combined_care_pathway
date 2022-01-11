class Link {
  String title = '';
  String url = '';

  Link(this.title, this.url);

  Link.fromJson(Map<String, dynamic> map) {
    title = map['title'];
    url = map['url'];
  }
}
