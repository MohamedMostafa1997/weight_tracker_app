import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker_app/features/weight/business_logic/cubit/weight_cubit.dart';
import 'package:weight_tracker_app/features/weight/model/weight_entry.dart';

import 'edit_weight_dialog.dart';

class WeightTileCard extends StatelessWidget {
  final WeightEntry entry;
  const WeightTileCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final formatted = DateFormat('yyyy-MM-dd – HH:mm').format(entry.dateTime.toLocal());
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        title: Text('${entry.weight.toStringAsFixed(1)} kg', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(formatted),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit, color: Colors.orange), onPressed: () => showEditWeightDialog(context, entry)),
            IconButton(icon: const Icon(Icons.delete, color: Colors.redAccent), onPressed: () => context.read<WeightCubit>().deleteWeight(entry.id)),
          ],
        ),
      ),
    );
  }
}
