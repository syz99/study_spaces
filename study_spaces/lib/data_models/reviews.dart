import 'package:meta/meta.dart';
import 'package:study_spaces/data_models/user.dart';


enum Productivity{
 NOT_PRODUCTIVE, PRODUCTIVE
}

enum NoiseLevel{
  LOW, AVERAGE, HIGH
}

enum StressLevel{
  LOW, AVERAGE, HIGH
}

class Review {
  Review({
    @required this.productivity,
    @required this.noiseLevel,
    @required this.stress,
    @required this.startTime,
    @required this.endTime,
    @required this.timestamp,
    @required this.spaceId,
    @required this.userId

});


  final Productivity productivity;


  final NoiseLevel noiseLevel;

  final StressLevel stress;

  final DateTime startTime;

  final DateTime endTime;

  final DateTime timestamp;
  final int spaceId;
  final int userId;

}