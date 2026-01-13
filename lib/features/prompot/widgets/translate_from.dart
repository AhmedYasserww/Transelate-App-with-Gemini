import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TranslateFrom extends StatefulWidget {
  final TextEditingController controller;
  final String? language;

  const TranslateFrom({
    super.key,
    required this.controller,
    this.language,
  });

  @override
  State<TranslateFrom> createState() => _TranslateFromState();
}

class _TranslateFromState extends State<TranslateFrom> {
  int _wordCount = 0;
  final int _wordLimit = 50;
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateWordCount);
  }

  void _updateWordCount() {
    final text = widget.controller.text;
    setState(() {
      _wordCount = _countWords(text);
      if (_wordCount > _wordLimit) {
        widget.controller.value = widget.controller.value.copyWith(
          text: _truncateTextToWordLimit(text, _wordLimit),
          selection: TextSelection.fromPosition(
            TextPosition(offset: widget.controller.text.length),
          ),
        );
        _wordCount = _wordLimit;
      }
    });
  }

  int _countWords(String text) {
    if (text.isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).length;
  }

  String _truncateTextToWordLimit(String text, int wordLimit) {
    final words = text.trim().split(RegExp(r'\s+'));
    return words.take(wordLimit).join(' ');
  }

  Future<void> _handleVolumeUpTap() async {
    final text = widget.controller.text;
    if (text.isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateWordCount);
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLight ? Colors.white : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isLight ? 0.05 : 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        children: [
          /// SHOW SELECTED LANGUAGE
          // if (widget.language != null)
          //   Text(
          //     "Language: ${widget.language!}",
          //     style: GoogleFonts.poppins(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w500,
          //       color: isLight ? Colors.purple.shade700 : Colors.purple.shade200,
          //     ),
          //   ),
          // if (widget.language != null) const SizedBox(height: 10),

          /// TEXT INPUT
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              maxLines: null,
              expands: true,
              style:TextStyle(
                  fontSize: 16,
                  color: isLight ? Colors.black87 : Colors.white),
              decoration: InputDecoration(
                hintText: 'Type your text here...',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: isLight ? Colors.grey.shade400 : Colors.grey.shade300,
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 12),
          Divider(
              color: (isLight ? Colors.purple.shade700 : Colors.purple.shade200)
                  .withOpacity(0.15)),
          const SizedBox(height: 6),

          /// BOTTOM BAR
          Row(
            children: [
              Text(
                '$_wordCount / $_wordLimit words',
                style: TextStyle(
                  fontSize: 12,
                  color: _wordCount >= _wordLimit
                      ? Colors.redAccent
                      : isLight
                      ? Colors.grey.shade600
                      : Colors.grey.shade300,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _handleVolumeUpTap,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (isLight
                        ? Colors.purple.shade700
                        : Colors.purple.shade200)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.volume_up_outlined,
                    size: 22,
                    color: isLight ? Colors.purple.shade700 : Colors.purple.shade200,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
