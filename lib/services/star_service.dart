import 'package:hive_flutter/hive_flutter.dart';
import 'package:transelate_app/models/transelation_model.dart';

class StarService {
  final Box<Translation> box = Hive.box<Translation>('stars');

  void addStar(String original, String translated) {
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
  bool isStarred(String original, String translated) {
    return box.values.any(
          (t) => t.originalText == original && t.translatedText == translated,
    );
  }

  void removeStar(String original, String translated) {
    final key = box.keys.firstWhere(
          (k) {
        final t = box.get(k);
        return t!.originalText == original && t.translatedText == translated;
      },
    );
    box.delete(key);
  }

}
