import 'package:cloud_firestore/cloud_firestore.dart';

class ShowModel {
  final String docId;
  final String userId;
  final String title;
  final String description;
  final String timeAndDate;
  final String image;
  final String showLocation;

  ShowModel({
    required this.userId,
    required this.description,
    required this.timeAndDate,
    required this.image,
    required this.title,
    required this.docId,
    required this.showLocation,
  });

  factory ShowModel.fromDoc(DocumentSnapshot snap) {
    return ShowModel(
      userId: snap['userId'],
      description: snap['description'],
      timeAndDate: snap['timeAndDate'],
      image: snap['image'],
      title: snap['title'],
      docId: snap['docId'],
      showLocation: snap['showLocation'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'docId': docId,
      'title': title,
      'description': description,
      'image': image,
      'timeAndDate': timeAndDate,
      'showLocation': showLocation,
    };
  }
}
