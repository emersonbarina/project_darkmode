import 'package:flutter/material.dart';
import 'package:project_darkmode/app_theme.dart';
import 'package:project_darkmode/screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant/constant.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLightTheme = prefs.getBool(SPref.isLight) ?? true;
  bool isOsThemeOn = prefs.getBool(SPref.isOsTheme) ?? false;
  print("Tema (main): ${isOsThemeOn}");
  if (isOsThemeOn) {
    // se true, deve seguir o padrão do tema do sistema operacional
    var brightness = WidgetsBinding.instance.window.platformBrightness;
    brightness == Brightness.dark ?  isLightTheme = false : isLightTheme = true;
  }
  runApp(AppStart(
      isLightTheme: isLightTheme,
      isOsThemeOn: isOsThemeOn,
  ));
}

class AppStart extends StatelessWidget {
  const AppStart({super.key, required this.isLightTheme, required this.isOsThemeOn});
  final bool isLightTheme;
  final bool isOsThemeOn;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => ThemeProvider(isLightTheme: isLightTheme, isOsThemeOn: isOsThemeOn),
      ),
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData(),
      home: const HomeScreen(),
    );
  }
}

