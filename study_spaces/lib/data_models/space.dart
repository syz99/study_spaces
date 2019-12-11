


import 'package:meta/meta.dart';
import 'package:study_spaces/data_models/reviews.dart';

// Define enums
enum SpaceCategory {
  category1,
  category2,
  category3
}

class StudySpace {
  StudySpace({
    @required this.id,
    @required this.longitude,
    @required this.latitude,
    @required this.name,
    @required this.category,
    @required this.reviewIds,
    @required this.imageUrl,
    this.userUID,
    this.description,
  });

  StudySpace.fromMap(Map snapshot) {
    this.id = snapshot["id"]  ?? '';
    this.name = snapshot['name'] ?? '';
    this.latitude =snapshot['latitude'] ?? 0;
    this.longitude = snapshot['longitude'] ?? 0;
    this.imageUrl = snapshot['imageUrl'] ?? 'images/default.jpg';
    this.reviewIds = snapshot['reviews'] ?? new List<String>(0);
    this.category = snapshot['category'] ?? '';
    this.userUID = snapshot['userUID'] ?? 'ADMIN_SPACE';
    this.description = snapshot['description'] ?? '';
  }

  String id;

  String userUID;

  String name;

  double longitude;

  String description;

  double latitude;

  String category;

  List<String> reviewIds;

  String imageUrl;



}