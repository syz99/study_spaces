
import 'package:scoped_model/scoped_model.dart';
import 'package:study_spaces/data_models/reviews.dart';
import 'package:study_spaces/data_models/space.dart';
import 'package:study_spaces/data_models/user.dart';
import 'package:study_spaces/data_models/fake_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AppState extends Model {
  List<User> _users;
  List<StudySpace> _spaces;
  List<Review> _reviews;

  AppState() : _users = FakeData.users,
               _spaces = FakeData.spaces;

  List<User> get allUsers => List<User>.from(_users);
  List<Review> get allReviews => List<Review>.from(_reviews);
  List<StudySpace> get allSpaces => List<StudySpace>.from(_spaces);


  // Define method to obtain Study Space / User from id
  User getUser(int id) => _users.singleWhere((v) => v.id == id);
  StudySpace getSpace(int id) => _spaces.singleWhere((v) => v.id == id);

  // Get All Reviews and add them to the respective users
  //getAllReviews();

//  List<Review> getReviewsFromSpace(int spaceId) {
//    List<Review> reviews = [];
//    int userId = 1; //TODO: MAKE THIS PROGRAMATIC
//    for (Review r in _reviews) {
//      if (r.spaceId == spaceId && r.userId == 1){
//        reviews.add(r);
//      }
//    }
//    return reviews;
//  }

  Future<List<Review>> getReviewsFromSpace(int spaceId) async {
    List<Review> reviews = [];
    for(Review r in _reviews) {
      if (r.spaceId == spaceId && r.userId == 1){
        reviews.add(r);
      }
    }
    return reviews;
  }

  Future<List<Review>> getAllReviews() async{
    Firestore.instance
        .collection("reviews")
        .snapshots().listen((data) => data.documents.forEach((doc) =>
        _reviews.add(Review(
          startTime: (doc["startTime"] as Timestamp).toDate(),
          endTime: (doc["endTime"] as Timestamp).toDate(),
          id: doc.documentID,
          userId: doc["userId"],
          spaceId: doc["spaceId"],
          noiseLevel: NoiseLevel.HIGH, //TODO: MAKE A FUNCTION TO PARSE THESE
          productivity: Productivity.PRODUCTIVE,
          stress: StressLevel.HIGH
        ))
    ));
    notifyListeners();
    return _reviews;
  }


  // Add review to Spaces and Users
  void addReview(Review review)  {
    User user = getUser(review.userId); //get user
    // Add reviews to respective objects
    user.submittedReviews.add(review);
    notifyListeners();

    // EXPERIMENTAL -> Add new review to database
    DocumentReference inst = Firestore.instance.collection('reviews').document();
    String id = inst.documentID;
    inst.setData({ 'endTime': review.endTime,
                    'id': 1,
      "startTime": review.startTime,
      "noiseLevel": review.noiseLevel.toString().split(".")[1],
      "stressLevel": review.stress.toString().split(".")[1],
      "productivity": review.productivity.toString().split(".")[1],
      "userId": review.userId,
      "spaceId": review.spaceId
      });




  }

}