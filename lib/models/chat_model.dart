import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String? id;
  final String? uid;
  final String? text;
  var sentOn; // Firestore Timestamp

  ChatModel({
    this.id,
    this.uid,
    this.text,
    this.sentOn,
  });

  // Factory method to create an instance from a JSON map
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      uid: json['uid'],
      text: json['text'],
      sentOn: json['sent_on'],
    );
  }

  // Factory method to create an instance from a firestore Doc
  factory ChatModel.fromDocSnapshot(DocumentSnapshot<Object?> docSnapshot) {
    return ChatModel(
      id: docSnapshot['id'],
      uid: docSnapshot['uid'],
      text: docSnapshot['text'],
      sentOn: docSnapshot['sent_on'],
    );
  }

  // Method to convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'text': text,
      'sent_on': sentOn,
    };
  }
}
