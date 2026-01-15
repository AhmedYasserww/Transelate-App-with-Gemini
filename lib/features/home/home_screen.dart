import 'package:flutter/material.dart';
import 'package:transelate_app/features/home/widgets/arrrow_button.dart';
import 'package:transelate_app/features/home/widgets/country_grid_view.dart';
import 'package:transelate_app/features/home/widgets/home_title.dart';

import '../../main.dart';
import '../prompot/prompt_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onArrowTap() async {
    await _controller.forward();
    await _controller.reverse();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PromptScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title:  Text("Transly",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isLight ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              TranslateApp.toggleTheme();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLight
                ? [
              const Color(0xFFFDF6F0),
              const Color(0xFFEDE7F6).withOpacity(0.6)
            ]
                : [Colors.grey.shade900, Colors.black87],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10),
                        const CountryGridView(),

                        const SizedBox(height: 20),

                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const HomeTitle(),
                              const SizedBox(height: 16),
                              ArrowButton(
                                  controller: _controller, onTap: _onArrowTap),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),

    );
  }
}
