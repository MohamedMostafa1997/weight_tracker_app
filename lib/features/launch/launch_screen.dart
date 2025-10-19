import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker_app/core/routing/routes.dart';
import 'package:weight_tracker_app/features/auth/business_logic/auth_repo.dart';
import 'package:weight_tracker_app/features/auth/business_logic/cubit/auth_cubit.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {


  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    final user =  await context.read <AuthCubit>().checkUser();
    print("fkaslfgaslfgakjgaasfasfgasfasgasgsagasgsagljkghlakghlakshga");
    print(user);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      Navigator.pushReplacementNamed(
          context, user == null ? Routes.auth : Routes.weight);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
