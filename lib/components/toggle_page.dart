// import 'package:flutter/material.dart';
//
// import '../screens/home_screen.dart';
// import '../screens/prompt_screen.dart';
//
//
// class TogglePage extends StatefulWidget {
//   const TogglePage({super.key});
//
//   @override
//   State<TogglePage> createState() => _TogglePageState();
// }
//
// class _TogglePageState extends State<TogglePage> {
//   bool _showHomeScreen = true;
//   void _togglePage() {
//     setState(() {
//       _showHomeScreen = !_showHomeScreen;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSwitcher(
//       duration: const Duration(milliseconds: 400),
//       transitionBuilder: (child, animation) =>
//           FadeTransition(opacity: animation, child: child),
//       child: _showHomeScreen
//           ? HomeScreen(key: const ValueKey('home'), ShowPromptScreen: _togglePage)
//           : PromptScreen(key: const ValueKey('prompt'), ShowHomeScreen: _togglePage),
//     );
//   }
// }
