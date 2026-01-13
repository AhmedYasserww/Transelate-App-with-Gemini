part of 'translation_cubit.dart';

@immutable
sealed class TranslationState {}

final class TranslationInitial extends TranslationState {}
final class TranslationLoading extends TranslationState {}
final class TranslationSuccess extends TranslationState {
  final TranslateModel translateModel;
  TranslationSuccess({required this.translateModel});
}
final class TranslationFailure extends TranslationState {
  final String errorMessage;
  TranslationFailure({required this.errorMessage});
}

