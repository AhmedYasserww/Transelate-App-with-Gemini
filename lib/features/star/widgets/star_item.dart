import 'package:flutter/material.dart';
import '../../../models/transelation_model.dart';

class StarItem extends StatelessWidget {
  final Translation translation;
  final VoidCallback onDelete;

  const StarItem({
    super.key,
    required this.translation,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

        title: Text(
          translation.originalText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            translation.translatedText,
            style: const TextStyle(fontSize: 15),
          ),
        ),

        trailing: InkWell(
          onTap: onDelete,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red.withOpacity(0.1),
            ),
            child: const Icon(Icons.close, color: Colors.red, size: 20),
          ),
        ),
      ),
    );
  }
}
