import 'package:meta/meta.dart';
import 'package:study_spaces/data_models/reviews.dart';

enum UserType {
  ADMIN, STUDENT
}

class User {
  User({
    @required this.name,
    @required this.email,
    @required this.phoneNumber,
    @required this.type,
    @required this.submittedReviews
});


  final String name;
  final String email;
  final String phoneNumber;
  final UserType type;
  final List<Reviews> submittedReviews;
}

