import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker_app/features/weight/business_logic/cubit/weight_cubit.dart';
import 'package:weight_tracker_app/features/weight/model/weight_entry.dart';


void showEditWeightDialog(BuildContext context, WeightEntry entry) {
  final TextEditingController textEditingController = TextEditingController(text: entry.weight.toStringAsFixed(1));
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Edit weight'),
      content: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Weight (kg)'),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            final value = double.tryParse(textEditingController.text);
            if (value != null) {
              context.read<WeightCubit>().updateWeight(entry.id, value);
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        )
      ],
    ),
  );
}
