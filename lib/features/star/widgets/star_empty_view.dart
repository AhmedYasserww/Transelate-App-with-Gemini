import 'package:flutter/material.dart';

class StarEmptyView extends StatelessWidget {
  const StarEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No starred words yet ⭐",
        style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }
}
