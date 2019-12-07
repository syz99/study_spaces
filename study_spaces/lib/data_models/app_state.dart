
import 'package:scoped_model/scoped_model.dart';
import 'package:study_spaces/data_models/reviews.dart';
import 'package:study_spaces/data_models/space.dart';
import 'package:study_spaces/data_models/user.dart';
import 'package:study_spaces/data_models/fake_data.dart';
class AppState extends Model {
  List<User> _users;
  List<StudySpace> _spaces;

  AppState() : _users = FakeData.users,
               _spaces = FakeData.spaces;

  List<User> get allUsers => List<User>.from(_users);
  List<StudySpace> get allSpaces => List<StudySpace>.from(_spaces);


  // Define method to obtain Study Space / User from id
  User getUser(int id) => _users.singleWhere((v) => v.id == id);
  StudySpace getSpace(int id) => _spaces.singleWhere((v) => v.id == id);

  List<Review> getReviewsFromSpace(int spaceId) {
    List<Review> reviews = [];
    int userId = 1; //TODO: MAKE THIS PROGRAMATIC
    for (Review r in getUser(userId).submittedReviews) {
      if (r.spaceId == spaceId){
        reviews.add(r);
      }
    }
    return reviews;
  }


  // Add review to Spaces and Users
  void addReview(Review review)  {
    StudySpace space = getSpace(review.spaceId); // Get Space
    User user = getUser(review.spaceId); //get user
    // Add reviews to respective objects
    space.reviews.add(review);
    user.submittedReviews.add(review);
    notifyListeners();
  }

}