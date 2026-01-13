import 'package:flutter/material.dart';

class HistoryEmptyView extends StatelessWidget {
  const HistoryEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No translations found",
        style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }
}
