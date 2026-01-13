import 'package:hive/hive.dart';

part 'transelation_model.g.dart';

@HiveType(typeId: 1)
class Translation extends HiveObject {
  @HiveField(0)
  final String originalText;

  @HiveField(1)
  final String translatedText;

  Translation({
    required this.originalText,
    required this.translatedText,
  });
}
