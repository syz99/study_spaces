


import 'package:study_spaces/data_models/reviews.dart';
import 'package:study_spaces/data_models/space.dart';
import 'package:study_spaces/data_models/user.dart';

class FakeData {
  // Create Fake User Data
  static List<User> users = [
      User(
        id: 1,
        name: "José San Martin",
        email: "josesm919@gmail.com",
        phoneNumber: "919-753-6779",
        isAdmin: false,
        submittedReviews: [
//          Review(
//            id:"holder",
//            productivity: Productivity.PRODUCTIVE,
//            noiseLevel: NoiseLevel.AVERAGE,
//            stress: StressLevel.HIGH,
//            startTime: new DateTime(2019, 12, 1, 14),
//            endTime: new DateTime(2019, 12, 1, 19),
//            timestamp: new DateTime(2019, 12, 2,21),
//            spaceId: 1,
//            userId: 1
//          ),
//          Review(
//              id:"holder",
//              productivity: Productivity.NOT_PRODUCTIVE,
//              noiseLevel: NoiseLevel.HIGH,
//              stress: StressLevel.HIGH,
//              startTime: new DateTime(2019, 10, 1, 12),
//              endTime: new DateTime(2019, 10, 1, 21),
//              timestamp: new DateTime(2019, 10, 2,21),
//              spaceId: 1,
//              userId: 1
//          )
        ]
      )
  ];

  // Create Fake Space Data
 static List<StudySpace> spaces = [
    StudySpace(
      id: 1,
      name: "Perkins",
      longitude: 36.0023,
      latitude: -78.9386,
      category: SpaceCategory.category1,
      imageUrl: "images/perkins.png",

    ),
   StudySpace(
     id: 2,
     name: "Lilly",
     longitude: 39.1679,
     latitude: -86.5190,
     category: SpaceCategory.category1,
     imageUrl: "images/lilly.jpg",
   ),
   StudySpace(
       id: 3,
       name: "West Union",
       longitude: 36.0009,
       latitude: -78.9393,
       category: SpaceCategory.category1,
       imageUrl: "images/westunion.jpg",
   )
   
 ];


}