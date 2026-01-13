import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:transelate_app/models/transelation_model.dart';
import '../../services/star_service.dart';
import 'widgets/star_app_bar.dart';
import 'widgets/star_empty_view.dart';
import 'widgets/star_list_view.dart';

class StarScreen extends StatefulWidget {
  final String originalWord;
  final String translatedWord;

  const StarScreen({
    super.key,
    required this.originalWord,
    required this.translatedWord,
  });

  @override
  State<StarScreen> createState() => _StarScreenState();
}

class _StarScreenState extends State<StarScreen> {
  final StarService _service = StarService();

  @override
  Widget build(BuildContext context) {
    final box = _service.box;

    return Scaffold(
      appBar: StarAppBar(onClear: () {
        if (box.isNotEmpty) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Clear Favorites?'),
              content: const Text('Delete all starred words?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                TextButton(
                  onPressed: () {
                    _service.clearAll();
                    Navigator.pop(context);
                  },
                  child: const Text('Clear', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
        }
      }),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (_, Box<Translation> box, __) {
          if (box.isEmpty) return const StarEmptyView();
          return StarListView(box: box, onDelete: _service.deleteAt);
        },
      ),
    );
  }
}
