import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transelate_app/features/prompot/widgets/language_bar.dart';
import 'package:transelate_app/features/prompot/widgets/prompt_header.dart';
import 'package:transelate_app/features/prompot/widgets/section_container.dart';
import 'package:transelate_app/features/prompot/widgets/section_title.dart';
import 'package:transelate_app/features/prompot/widgets/translate_button_bar.dart';
import 'package:transelate_app/features/prompot/widgets/translate_from.dart';
import 'package:transelate_app/features/prompot/widgets/translate_to.dart';

import '../../manager/translation_cubit.dart';
import '../history/history_screen.dart';
import '../star/star_screen.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  String? selectCountryFrom;
  String? selectCountryTo;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          child: Column(
            children: [
              PromptHeader(
                isLight: isLight,
                onHistoryTap: _openHistory,
                onStarTap: _openStar,
              ),


              const SizedBox(height: 8),

              LanguageBar(
                isLight: isLight,
                onFromChanged: (v) => setState(() => selectCountryFrom = v),
                onToChanged: (v) => setState(() => selectCountryTo = v),
              ),

              const SizedBox(height: 16),

              SectionTitle(
                title: "Translate From",
                language: selectCountryFrom,
                isLight: isLight,
              ),

              const SizedBox(height: 10),

              SectionContainer(
                isLight: isLight,
                child: TranslateFrom(
                  controller: controller,
                  language: selectCountryFrom,
                ),
              ),

              const SizedBox(height: 16),

              SectionTitle(
                title: "Translate To",
                language: selectCountryTo,
                isLight: isLight,
              ),

              const SizedBox(height: 10),

              SectionContainer(
                isLight: isLight,
                child: _buildTranslationResult(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: TranslateButtonBar(onTap: _translateText),
    );
  }
  // ================== OPEN HISTORY ==================
  void _openHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HistoryScreen(
          orignalWord: controller.text,
          translatedWord: context.read<TranslationCubit>().state
          is TranslationSuccess
              ? (context.read<TranslationCubit>().state as TranslationSuccess)
              .translateModel
              .translatedText
              : '',
        ),
      ),
    );
  }
  void _openStar() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StarScreen(
          originalWord: controller.text,
          translatedWord: context.read<TranslationCubit>().state is TranslationSuccess
              ? (context.read<TranslationCubit>().state as TranslationSuccess)
              .translateModel
              .translatedText
              : '',
        ),
      ),
    );
  }

  // ================== TRANSLATE ==================
  Future<void> _translateText() async {
    final inputText = controller.text;

    if (inputText.isEmpty ||
        selectCountryFrom == null ||
        selectCountryTo == null) {
      String message = '';

      if (inputText.isEmpty) {
        message = 'What are you translating?';
      } else if (selectCountryFrom == null) {
        message = 'What language are you translating from?';
      } else {
        message = 'What language are you translating to?';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: Text(message, style: const TextStyle(color: Colors.white)),
        ),
      );
      return;
    }

    context.read<TranslationCubit>().translate(
      prompt: inputText,
      fromLanguage: selectCountryFrom!,
      toLanguage: selectCountryTo!,
    );
  }
// ================== BUILD TRANSLATION RESULT ==================
  Widget _buildTranslationResult() {
    return BlocConsumer<TranslationCubit, TranslationState>(
      listener: (context, state) {
        if (state is TranslationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: Colors.red, content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        if (state is TranslationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TranslationSuccess) {
          return TranslateTo(
            translatedText: state.translateModel.translatedText,
            originalText: controller.text,
          );

        }
        return TranslateTo(translatedText: '', originalText: '');
      },
    );
  }


}
