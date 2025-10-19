import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker_app/core/routing/routes.dart';
import 'package:weight_tracker_app/features/auth/business_logic/auth_repo.dart';
import 'package:weight_tracker_app/features/auth/business_logic/cubit/auth_cubit.dart';
import 'package:weight_tracker_app/features/weight/business_logic/cubit/weight_cubit.dart';
import 'package:weight_tracker_app/features/weight/widgets/weight_input_card.dart';
import 'package:weight_tracker_app/features/weight/widgets/weight_tile_card.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});
  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final AuthRepo authRepo = AuthRepo();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeightCubit>().startListening();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F5FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My Weight Progress',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black54),
            onPressed: () => signOut(),
          ),
        ],
      ),
      body: BlocBuilder<WeightCubit, WeightState>(
        builder: (context, state) {
          if (state is WeightLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeightLoaded) {
            final list = state.weights;
            return Column(
              children: [
                SizedBox(height: 20),
                WeightInputCard(),

                SizedBox(height: 10),
                Expanded(
                  child: list.isEmpty
                      ? Center(
                          child: Text('No weights yet. Add your first weight.'),
                        )
                      : ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, i) =>
                              WeightTileCard(entry: list[i]),
                        ),
                ),
                SizedBox(height: 12),
              ],
            );
          } else if (state is WeightFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return SizedBox();
        },
      ),
    );
  }

  void signOut() async {
    await context.read<AuthCubit>().signOut();

    if (mounted) {
      Navigator.pushReplacementNamed(context, Routes.auth);
    }
  }
}
