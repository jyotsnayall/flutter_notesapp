class NotesModel {
  String title;
  String description;
  String id;
  bool isPinned;

  NotesModel({
    required this.title,
    required this.description,
    required this.id,
    required this.isPinned,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotesModel &&
        other.title == title &&
        other.description == description &&
        other.id == id &&
        other.isPinned == isPinned;
  }

  @override
  int get hashCode {
    return title.hashCode ^ description.hashCode ^ id.hashCode ^ isPinned.hashCode;
  }
}
