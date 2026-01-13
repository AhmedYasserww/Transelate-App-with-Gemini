import 'package:dartz/dartz.dart';
import '../errors/faluire.dart';
import '../models/transilate_model.dart';


abstract class TranslationRepo {
  Future<Either<Failure, TranslateModel>> translateText({
    required String prompt,
    required String fromLanguage,
    required String toLanguage,
  });
}
