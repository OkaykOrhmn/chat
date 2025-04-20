import 'package:chat/data/storage/shared_preferences_helper.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/ui/pages/auth/auth_gate.dart';
import 'package:chat/ui/pages/auth/cubit/auth_cubit.dart';
import 'package:chat/ui/pages/auth/provider/user_provider.dart';
import 'package:chat/ui/theme/theme_brightnes_changer.dart';
import 'package:chat/ui/theme/theme_changer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  await SharedPreferencesHelper.initialize();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<ThemeBrightnesChanger>(
          create: (_) => ThemeBrightnesChanger()),
      ChangeNotifierProvider<ThemeChanger>(create: (_) => ThemeChanger()),
      ChangeNotifierProvider<UserProvider>(
        create: (context) => UserProvider()..checkMyInformation(),
      ),
      BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(
          scheme: context.watch<ThemeChanger>().theme, useMaterial3: true),
      // The Mandy red, dark theme.
      darkTheme: FlexThemeData.dark(
          scheme: context.watch<ThemeChanger>().theme, useMaterial3: true),
      // Use dark or light theme based on system setting.
      themeMode: Provider.of<ThemeBrightnesChanger>(context).themeMode,

      home: AuthGate(),
    );
  }
}
