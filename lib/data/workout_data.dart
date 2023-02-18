import 'package:flutter/material.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workout.dart';

class WorkoutData extends ChangeNotifier {
  List<Workout> workoutList = [
    Workout(name: "upper Body", exercises: [
      Exercise(name: "Bicep Curls", weight: "10", reps: "10", sets: "3")
    ])
  ];

  //get length of workout
  int getLengthOfWorkout(String workoutName) {
    Workout relevantWorkoutName = getRelevantWorkout(workoutName);

    return relevantWorkoutName.exercises.length;
  }

  //get list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  //add a workout
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));
    notifyListeners();
  }

  //add an exercise to a workout
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    //find relevantWorkout
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(
        Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets));
    notifyListeners();
  }

  //check off exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    //find relevant exercise in that workout
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    // check off boolean to show usercompleted
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
  }

  //return relevant workout object given relevant workout name
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);

    return relevantWorkout;
  }

  //return relevant exercise given relevant workout name + exercise name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    //find relevant workout first
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    //find relevant exercise
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);

    return relevantExercise;
  }
}
