import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:toggle/AppLocalizations.dart';
import 'package:toggle/constants.dart';
import 'package:toggle/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  print("base_url: ${GlobalConfiguration().getString('base_url')}");
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();

  void setlocal(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      localeResolutionCallback: (devicelocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == devicelocale.languageCode &&
              locale.countryCode == devicelocale.countryCode) {
            return devicelocale;
          }
        }
        return supportedLocales.first;
      },
      supportedLocales: [
        Locale("en", ""),
        Locale("ar", ""),
      ],
      home: SplashScreen(),
    );
  }
}

