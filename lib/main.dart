import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker_app/core/routing/app_router.dart';
import 'package:weight_tracker_app/core/routing/routes.dart';
import 'package:weight_tracker_app/observer/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  runApp(const WeightTrackerApp());
}

class WeightTrackerApp extends StatelessWidget {
  const WeightTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weight Tracker',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.launch,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
