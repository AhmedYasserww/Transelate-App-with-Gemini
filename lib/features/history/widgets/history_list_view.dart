import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:transelate_app/models/transelation_model.dart';
import 'history_item.dart';

class HistoryListView extends StatelessWidget {
  final Box<Translation> box;
  final Function(int) onDelete;

  const HistoryListView({super.key, required this.box, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final translations = box.values.toList().reversed.toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: translations.length,
      itemBuilder: (_, index) => HistoryItem(
        translation: translations[index],
        onDelete: () => onDelete(index),
      ),
    );
  }
}
