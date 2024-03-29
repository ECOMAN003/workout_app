import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/pages/workout_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controller
  final newWorkoutController = TextEditingController();

  //create a new workout
  void createNewWorkout() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Create New Workout"),
              content: TextField(
                controller: newWorkoutController,
              ),
              actions: [
                //save button
                MaterialButton(
                  onPressed: save,
                  child: const Text("save"),
                ),
                //cancel button
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("cancel"),
                ),
              ],
            ));
  }

  void goToWorkoutPage(String workoutName) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorkoutPage(
          workoutName: workoutName,
        )));
  }

  //save workout
  void save() {
    //get workout from text controller
    String newWorkoutName = newWorkoutController.text;
    //add workout to workoutdata list
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
    //pop dialog box
    Navigator.pop(context);
    clear();
  }

  //cancel workout
  void cancel() {
    //pop dialgo box
    Navigator.pop(context);
    clear();
  }

  //clear controller
  void clear() {
    newWorkoutController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Workout Tracker"),
        ),
        body: ListView.builder(
            itemCount: value.getWorkoutList().length,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.all(Radius.circular(5.0))
              ),
              child: ListTile(
                    title: Text(value.getWorkoutList()[index].name),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () => 
                      goToWorkoutPage(value.getWorkoutList()[index].name),
                    ),
                  ),
            )),
        floatingActionButton: FloatingActionButton(
            onPressed: createNewWorkout, child: const Icon(Icons.add)),
      ),
    );
  }
}
