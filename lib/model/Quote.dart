class Quote {
  final String id;
  final String content;
  final String author;
  final List<String> tags;
  final String authorSlug;
  final int length;
  final String dateAdded;
  final String dateModified;
  late final String firstLine;
  late final String secondLine;

  Quote({
    required this.id,
    required this.content,
    required this.author,
    required this.tags,
    required this.authorSlug,
    required this.length,
    required this.dateAdded,
    required this.dateModified,
  }) {
    // Split the content into two lines
    final List<String> contentLines = content.split(' ');
    final int halfLength = (contentLines.length / 2).ceil();
    firstLine = contentLines.sublist(0, halfLength).join(' ');
    secondLine = contentLines.sublist(halfLength).join(' ');
  }

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['_id'],
      content: json['content'],
      author: json['author'],
      tags: List<String>.from(json['tags']),
      authorSlug: json['authorSlug'],
      length: json['length'],
      dateAdded: json['dateAdded'],
      dateModified: json['dateModified'],
    );
  }
}
