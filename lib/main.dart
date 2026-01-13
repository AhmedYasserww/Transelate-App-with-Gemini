import 'package:flutter/foundation.dart';
import 'package:transelate_app/models/transelation_model.dart';
import 'package:transelate_app/repos/transilation_repo_imp.dart';
import 'package:transelate_app/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/home/home_screen.dart';
import 'manager/translation_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();
  await Hive.initFlutter();
  Hive.registerAdapter(TranslationAdapter());
  await Hive.openBox<Translation>('translations');
  await Hive.openBox<Translation>('stars');

  await dotenv.load(fileName: ".env");

  runApp(
      const TranslateApp(),
      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => const TranslateApp(), // Wrap your app
      // ),
      );
}

class TranslateApp extends StatelessWidget {
  const TranslateApp({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return BlocProvider(
          create: (_) => TranslationCubit(getIt.get<TranslationRepoImpl>()),
          child: MaterialApp(
             debugShowCheckedModeBanner: false,
            // useInheritedMediaQuery: true,
            // locale: DevicePreview.locale(context),
            // builder: DevicePreview.appBuilder,
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: const Color(0xFF6D1B7B),
              scaffoldBackgroundColor: const Color(0xFFFDF6F0),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: const Color(0xFF6D1B7B),
              scaffoldBackgroundColor: const Color(0xFF1C1C1C),
            ),
            themeMode: currentMode,
            home: const HomeScreen(),
          ),
        );
      },
    );
  }
}
