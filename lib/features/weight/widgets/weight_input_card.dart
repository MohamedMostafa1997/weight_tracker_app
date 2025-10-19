import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker_app/features/weight/business_logic/cubit/weight_cubit.dart';

class WeightInputCard extends StatefulWidget {
  const WeightInputCard({super.key});
  @override
  State<WeightInputCard> createState() => _WeightInputCardState();
}

class _WeightInputCardState extends State<WeightInputCard> {
  final TextEditingController textEditingController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    final value = double.tryParse(textEditingController.text);
    if (value == null) return;
    await context.read<WeightCubit>().addWeight(value);
    textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter weight (kg)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _add,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                child: Text('Add', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
