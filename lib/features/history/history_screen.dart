import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:transelate_app/features/history/widgets/history_app_bar.dart';
import 'package:transelate_app/features/history/widgets/history_empty_view.dart';
import 'package:transelate_app/features/history/widgets/history_list_view.dart';
import 'package:transelate_app/features/history/widgets/history_service.dart';
import 'package:transelate_app/models/transelation_model.dart';

class HistoryScreen extends StatefulWidget {
  final String orignalWord;
  final String translatedWord;

  const HistoryScreen({
    super.key,
    required this.orignalWord,
    required this.translatedWord,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final HistoryService _service = HistoryService();

  @override
  void initState() {
    super.initState();
    _service.addTranslation(widget.orignalWord, widget.translatedWord);
  }

  @override
  Widget build(BuildContext context) {
    final box = _service.box;

    return Scaffold(
      appBar: HistoryAppBar(onClear: () {
        if (box.isNotEmpty) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Confirm Clear All'),
              content: const Text('Are you sure you want to delete all translations?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                TextButton(
                  onPressed: () {
                    _service.clearAll();
                    Navigator.pop(context);
                  },
                  child: const Text('Clear All', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
        }
      }),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (_, Box<Translation> box, __) {
          if (box.isEmpty) return const HistoryEmptyView();
          return HistoryListView(box: box, onDelete: _service.deleteAt);
        },
      ),
    );
  }
}
