import 'package:flutter/material.dart';

class StarAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClear;

  const StarAppBar({super.key, required this.onClear});

  @override
  Widget build(BuildContext context) {
   // final isLight = Theme.of(context).brightness == Brightness.light;

    return AppBar(
      backgroundColor: const Color(0xFF6D1B7B),
      centerTitle: true,
      title: const Text(
        'Starred Words',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_forever, color: Colors.red, size: 32),
          onPressed: onClear,
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
