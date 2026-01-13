class TranslateModel {
  final String translatedText;
  final int statusCode;
  final String message;

  TranslateModel({
    required this.translatedText,
    required this.statusCode,
    required this.message,
  });

  factory TranslateModel.fromJson(Map<String, dynamic> json) {
    return TranslateModel(
      translatedText: json['data'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}
