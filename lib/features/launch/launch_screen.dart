import 'package:flutter/material.dart';
import 'package:weight_tracker_app/core/routing/routes.dart';
import 'package:weight_tracker_app/features/auth/business_logic/auth_repo.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  final _authRepo = AuthRepo();

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    final user = await _authRepo.getCurrentUser();
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
