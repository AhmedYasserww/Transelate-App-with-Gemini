import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:transelate_app/features/star/widgets/star_item.dart';

import '../../../models/transelation_model.dart';

class StarListView extends StatelessWidget {
  final Box<Translation> box;
  final Function(int) onDelete;

  const StarListView({super.key, required this.box, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final items = box.values.toList().reversed.toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (_, index) => StarItem(
        translation: items[index],
        onDelete: () => onDelete(index),
      ),
    );
  }
}
