import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:study_spaces/data_models/user.dart';


Productivity getProd(String s){
  if(s == "LOW"){
    return Productivity.NOT_PRODUCTIVE;
  }
  return Productivity.PRODUCTIVE;
}

NoiseLevel getNoise(String s){
  if(s == "LOW"){
    return NoiseLevel.LOW;
  }else if (s == "AVERAGE"){
    return NoiseLevel.AVERAGE;
  }else{
    return NoiseLevel.HIGH;
  }
}

StressLevel getStress(String s){
  if(s == "LOW"){
    return StressLevel.LOW;
  }else if (s == "AVERAGE"){
    return StressLevel.AVERAGE;
  }else{
    return StressLevel.HIGH;
  }
}

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
    @required this.id,
    @required this.productivity,
    @required this.noiseLevel,
    @required this.stress,
    @required this.startTime,
    @required this.endTime,
    @required this.spaceId,
    @required this.userId

});

  Review.fromMap(Map snapshot) {
    this.id = "holder";
    this.startTime=(snapshot["startTime"] as Timestamp).toDate() ?? 0;
    this.endTime = (snapshot['endTime'] as Timestamp).toDate() ?? 0;
    this.userId= snapshot['userId'] ?? '';
    this.spaceId = snapshot['spaceId'] ?? '';
    this.productivity = getProd(snapshot['productivity']) ?? '';
    this.stress = getStress(snapshot['stressLevel']) ?? '';
    this.noiseLevel = getNoise(snapshot['noiseLevel']) ?? '';

  }




   String id;


   Productivity productivity;


   NoiseLevel noiseLevel;

   StressLevel stress;

   DateTime startTime;

   DateTime endTime;
   String spaceId;
   String userId;

}