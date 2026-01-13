import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButtom extends StatelessWidget {
  CustomButtom({super.key, this.ontap, required this.text});
  VoidCallback? ontap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: GestureDetector(
        onTap: ontap,

        // Container for submit button
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: const Color(0xFF6D1B7B).withOpacity(0.8),
          ),

          // Submit text centered
          child: Center(
            // Submit text here
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
