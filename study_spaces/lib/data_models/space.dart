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
    @required this.reviews,
    @required this.imageUrl
});

  final int id;

  final String name;

  final double longitude;

  final double latitude;

  final SpaceCategory category;

  final List<Review> reviews;

  final String imageUrl;



}