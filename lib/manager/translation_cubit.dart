import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/transilate_model.dart';
import '../repos/transilation_repo.dart';

part 'translation_state.dart';

class TranslationCubit extends Cubit<TranslationState> {
  final TranslationRepo translationRepo;

  TranslationCubit(this.translationRepo) : super(TranslationInitial());
  Future<void> translate({
    required String prompt,
    required String fromLanguage,
    required String toLanguage,
  }) async {
    emit(TranslationLoading());

    final result = await translationRepo.translateText(
      prompt: prompt,
      fromLanguage: fromLanguage,
      toLanguage: toLanguage,
    );

    result.fold(
          (failure) {
        emit(
          TranslationFailure(errorMessage: failure.errorMessage),
        );
      },
          (data) {
        emit(
          TranslationSuccess(translateModel: data),
        );
      },
    );
  }
}

