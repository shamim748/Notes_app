import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String title;
  String description;
  Timestamp createdAt;
  Timestamp? updatedAt;
  bool? isPinned;
  String? id;
  NoteModel({
    required this.title,
    required this.description,
    required this.createdAt,
    this.id,
    this.updatedAt,
    this.isPinned,
  });
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      isPinned: json["isPinned"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "isPinned": isPinned,
    };
  }
}
