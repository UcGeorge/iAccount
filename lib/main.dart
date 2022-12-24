import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/home/home.dart';
import 'data/local/database_manager.dart';
import 'data/local/preference_manager.dart';
import 'util/log.util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LogUtil.init();
  await PreferenceManager.init();
  await DatabaseManager.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void dispose() {
    PreferenceManager.dispose();
    DatabaseManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'iAccount',
        theme: FlexThemeData.light(scheme: FlexScheme.hippieBlue),
        darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.hippieBlue,
          darkIsTrueBlack: true,
        ),
        themeMode: ThemeMode.dark,
        home: const HomePage(),
      ),
    );
  }
}
