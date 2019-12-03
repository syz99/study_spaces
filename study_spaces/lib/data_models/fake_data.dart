


import 'package:study_spaces/data_models/reviews.dart';
import 'package:study_spaces/data_models/spaces.dart';
import 'package:study_spaces/data_models/user.dart';

class FakeUserData {
  // Create Fake User Data
  static List<User> users = [
      User(
        id: 1,
        name: "José San Martin",
        email: "josesm919@gmail.com",
        phoneNumber: "919-753-6779",
        type: UserType.STUDENT,
        submittedReviews: [
          Review(
            productivity: Productivity.PRODUCTIVE,
            noiseLevel: NoiseLevel.AVERAGE,
            stress: StressLevel.HIGH,
            startTime: new DateTime(2019, 12, 1),
            endTime: new DateTime(2019, 12, 2),
            timestamp: new DateTime(2019, 12, 2),
            spaceId: 2
          ),
          Review(
              productivity: Productivity.NOT_PRODUCTIVE,
              noiseLevel: NoiseLevel.HIGH,
              stress: StressLevel.HIGH,
              startTime: new DateTime(2019, 10, 1),
              endTime: new DateTime(2019, 10, 2),
              timestamp: new DateTime(2019, 10, 2),
              spaceId: 1
          )
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
      category: Category.category1,
      reviews: [
        Review(
            productivity: Productivity.NOT_PRODUCTIVE,
            noiseLevel: NoiseLevel.HIGH,
            stress: StressLevel.HIGH,
            startTime: new DateTime(2019, 10, 1),
            endTime: new DateTime(2019, 10, 2),
            timestamp: new DateTime(2019, 10, 2),
            spaceId: 1
        )
      ]

    ),
   StudySpace(
     id: 2,
     name: "Lilly",
     longitude: 39.1679,
     latitude: -86.5190,
     category: Category.category1,
     reviews: [
       Review(
           productivity: Productivity.PRODUCTIVE,
           noiseLevel: NoiseLevel.AVERAGE,
           stress: StressLevel.HIGH,
           startTime: new DateTime(2019, 12, 1),
           endTime: new DateTime(2019, 12, 2),
           timestamp: new DateTime(2019, 12, 2),
           spaceId: 2
       ),
     ]
   )
   
 ];


}