import 'package:flutter/material.dart';
import 'package:hirepro/models/task.dart';
import 'package:hirepro/providers/task_provider.dart';
import 'package:hirepro/services/api.dart';
import 'package:hirepro/widgets/check_icon_large.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class JobCompletedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic id = ModalRoute.of(context)!.settings.arguments;
    Api api = Api();
    var starrating;
    return SafeArea(
        child: Scaffold(
            body: Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Particles.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CheckIconLarge(),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Job Complete',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const Text("Task has completed successfully!",
                style: TextStyle(fontSize: 15)),
            const SizedBox(
              height: 50,
            ),
            const Text('Rate Your Service Provider',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            RatingBar.builder(
              initialRating: 0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
                starrating = rating;
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  Navigator.popUntil(context, ModalRoute.withName("/ongoing"));
                  Provider.of<TaskProvider>(context, listen: false)
                      .getOngoingTasks();
                },
                child: Text("Continue"))
          ],
        ),
      ),
    )));
  }
}
