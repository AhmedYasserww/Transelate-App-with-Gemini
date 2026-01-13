import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';

import '../../../services/star_service.dart';

class TranslateTo extends StatefulWidget {
  final String translatedText;
  final String originalText;

  const TranslateTo({
    super.key,
    required this.translatedText,
    required this.originalText,
  });

  @override
  State<TranslateTo> createState() => _TranslateToState();
}

class _TranslateToState extends State<TranslateTo> {
  final FlutterTts _flutterTts = FlutterTts();
  final StarService _starService = StarService();

  bool _isStarred = false;

  @override

  void didUpdateWidget(covariant TranslateTo oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checkIfStarred();
  }

  void _checkIfStarred() {
    if (widget.translatedText.isEmpty || widget.originalText.isEmpty) {
      setState(() => _isStarred = false);
      return;
    }

    final exists = _starService.isStarred(
      widget.originalText,
      widget.translatedText,
    );

    setState(() => _isStarred = exists);
  }

  void _toggleStar() {
    if (widget.translatedText.isEmpty || widget.originalText.isEmpty) return;

    if (_isStarred) {
      _starService.removeStar(widget.originalText, widget.translatedText);
    } else {
      _starService.addStar(widget.originalText, widget.translatedText);
    }

    setState(() => _isStarred = !_isStarred);
  }

  void _copyToClipboard(String text) {
    if (text.isEmpty) return;
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  Future<void> _handleVolumeUpTap() async {
    if (widget.translatedText.isNotEmpty) {
      await _flutterTts.speak(widget.translatedText);
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Column(
      children: [
        /// TEXT AREA
        Expanded(
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.translatedText.isEmpty
                    ? 'Translation will appear here...'
                    : widget.translatedText,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: widget.translatedText.isEmpty
                      ? (isLight ? Colors.grey.shade400 : Colors.grey.shade300)
                      : (isLight ? Colors.black87 : Colors.white),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        Divider(
          color: (isLight ? Colors.purple.shade700 : Colors.purple.shade200)
              .withOpacity(0.15),
        ),
        const SizedBox(height: 6),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // ⭐ STAR FIRST
            GestureDetector(
              onTap: _toggleStar,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _isStarred ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 22,
                ),
              ),
            ),

            const SizedBox(width: 10),

            GestureDetector(
              onTap: () => _copyToClipboard(widget.translatedText),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (isLight ? Colors.purple.shade700 : Colors.purple.shade200)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.copy_all_outlined,
                  size: 22,
                  color: isLight ? Colors.purple.shade700 : Colors.purple.shade200,
                ),
              ),
            ),

            const SizedBox(width: 10),

            GestureDetector(
              onTap: _handleVolumeUpTap,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (isLight ? Colors.purple.shade700 : Colors.purple.shade200)
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
    );
  }
}
