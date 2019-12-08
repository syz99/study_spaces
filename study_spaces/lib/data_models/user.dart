import 'package:meta/meta.dart';
import 'package:study_spaces/data_models/reviews.dart';


class User {
  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.phoneNumber,
    @required this.isAdmin,
    @required this.submittedReviews,
});

  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final bool isAdmin;
  final List<Review> submittedReviews;
}

