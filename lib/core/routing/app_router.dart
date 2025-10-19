import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker_app/core/routing/routes.dart';
import 'package:weight_tracker_app/features/auth/auth_screen.dart';
import 'package:weight_tracker_app/features/auth/business_logic/auth_repo.dart';
import 'package:weight_tracker_app/features/auth/business_logic/cubit/auth_cubit.dart';
import 'package:weight_tracker_app/features/launch/launch_screen.dart';
import 'package:weight_tracker_app/features/weight/business_logic/weight_repo.dart';
import 'package:weight_tracker_app/features/weight/business_logic/cubit/weight_cubit.dart';
import 'package:weight_tracker_app/features/weight/weight_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.launch:
        return MaterialPageRoute(builder: (_) => const LaunchScreen());

      case Routes.auth:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => AuthCubit(AuthRepo()),
            child: const AuthScreen(),
          ),
        );

      case Routes.weight:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AuthCubit>(create: (_) => AuthCubit(AuthRepo())),

              BlocProvider<WeightCubit>(
                create: (_) => WeightCubit(WeightRepo()),
              ),
            ],
            child: const WeightScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
