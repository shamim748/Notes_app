import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class NoteModel {
  String title;
  String description;
  Timestamp createdAt;
  Timestamp? updatedAt;
  bool isPinned;
  String backgroundColor;
  String? id;
  NoteModel({
    required this.title,
    required this.description,
    required this.createdAt,
    this.updatedAt,
    this.id,
    required this.isPinned,
    required this.backgroundColor,
  });
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      isPinned: json["isPinned"],
      backgroundColor: json["bgColor"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "isPinned": isPinned,
      "bgColor": backgroundColor,
      "id": id,
    };
  }
}
