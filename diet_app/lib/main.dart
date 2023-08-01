import 'package:diet_app/Pages/exercisepage.dart';
import 'package:diet_app/services/testservice.dart';
import 'package:diet_app/widgets/bottomnavigationbar.dart';
import 'package:diet_app/Pages/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/loading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Pages/onboardingpage.dart';
import 'constants/constants.dart';
import 'Pages/register.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(EasyLocalization(
      child: MyApp(),
      supportedLocales: [LocaleConstants.enLocale, LocaleConstants.trLocale],
      saveLocale: true,
      fallbackLocale: LocaleConstants.enLocale,
      path: LocaleConstants.localePath));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      title: 'My Diet App',
      theme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: LoadingPage(),
      //initialRoute:
      // initScreen == 0 || initScreen == null ? 'onboard' : 'loading',
      routes: {
        'loading': (context) => LoadingPage(),
        'onboard': (context) => OnboardingPage(),
        'login': (context) => LoginPage(),
        'register': (context) => RegisterPage(),
        '/bottomnavigationbar': (context) => BottomNavigationBarPage(),
        'excercise': (context) => ExercisePage(),
      },
    );
  }
}
