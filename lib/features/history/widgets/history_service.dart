import 'package:transelate_app/models/transelation_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryService {
  final Box<Translation> box = Hive.box<Translation>('translations');

  void addTranslation(String original, String translated) {
    if (original.isEmpty || translated.isEmpty) return;

    final exists = box.values.any(
          (t) => t.originalText == original && t.translatedText == translated,
    );

    if (!exists) {
      box.add(Translation(originalText: original, translatedText: translated));
    }
  }

  void deleteAt(int index) {
    final key = box.keyAt(box.length - 1 - index);
    box.delete(key);
  }

  void clearAll() {
    box.clear();
  }
}
