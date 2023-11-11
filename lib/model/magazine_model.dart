import 'package:cloud_firestore/cloud_firestore.dart';

class MagazineModel {
  final String? docId;
  final String? userId;
  final String? image;
  final String? title;
  final String? description;
  final DateTime? createdAt;
  MagazineModel({
    this.docId,
    this.userId,
    this.image,
    this.title,
    this.description,
    this.createdAt,
  });

  factory MagazineModel.fromDoc(DocumentSnapshot snap) {
    return MagazineModel(
      docId: snap['docId'],
      userId: snap['userId'],
      title: snap['title'],
      description: snap['description'],
      createdAt: (snap['createdAt'].toDate()),
      image: snap['image'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'userId': userId,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'image': image,
    };
  }
}
