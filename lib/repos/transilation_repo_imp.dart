import 'package:flutter/material.dart';
import 'package:transelate_app/repos/transilation_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../errors/faluire.dart';
import '../models/transilate_model.dart';
import '../services/api_service.dart';

class TranslationRepoImpl implements TranslationRepo {
  final ApiService apiService;

  TranslationRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, TranslateModel>> translateText({
    required String prompt,
    required String fromLanguage,
    required String toLanguage,
  }) async {
    try {
      // طباعة البيانات قبل الإرسال
      debugPrint("TRANSLATION REQUEST => prompt: $prompt, from: $fromLanguage, to: $toLanguage");

      final response = await apiService.post(
        endPoint: "External/ask-ai",
        data: {
          "prompt": prompt,
          "fromLanguage": fromLanguage,
          "toLanguage": toLanguage,
        },
      );

      // طباعة الرد
      debugPrint("TRANSLATION RESPONSE => $response");

      if (response is Map && response["statusCode"] == 200) {
        // التأكد من تحويل البيانات بشكل آمن
        final data = Map<String, dynamic>.from(response);
        return Right(TranslateModel.fromJson(data));
      } else {
        // لو الرد فيه رسالة خطأ
        String errorMessage = "Translation failed";
        if (response is Map && response["message"] != null) {
          errorMessage = response["message"].toString();
        }
        debugPrint("TRANSLATION ERROR => $errorMessage");
        return Left(ServerFailure(errorMessage: errorMessage));
      }
    } on DioException catch (e) {
      // طباعة تفاصيل Dio exception
      debugPrint("DIO ERROR => ${e.message}");
      if (e.response != null) {
        debugPrint("DIO RESPONSE => ${e.response?.data}");
      }
      return Left(ServerFailure.fromDioError(e));
    } catch (e, s) {
      // أي استثناء آخر
      debugPrint("UNEXPECTED ERROR => $e");
      debugPrintStack(stackTrace: s);
      return Left(ServerFailure(errorMessage: "Unexpected error: $e"));
    }
  }
}
