import 'package:diet_app/Pages/accountsettings/accountsettings.dart';
import 'package:diet_app/categories/categories.dart';
import 'package:diet_app/Pages/mama.dart';
import 'package:diet_app/Pages/newpostpage.dart';
import 'package:diet_app/Pages/profilepage.dart';
import 'package:diet_app/Pages/resetpasswordpage.dart';
import 'package:diet_app/Pages/catsguide/guide1.dart';
import 'package:diet_app/firebase_options.dart';
import 'package:diet_app/widgets/bottomnavigationbar.dart';
import 'package:diet_app/Pages/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/emailverificationpage.dart';
import 'Pages/loading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Pages/onboardingpage.dart';
import 'constants/constants.dart';
import 'Pages/register.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:theme_manager/change_theme_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Pages/patinews.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  //Bildirim izni isteme kısmı!
  //await Permission.notification.isDenied.then((value) {
  //if (value) {
  //Permission.notification.request();
  //}
  //});
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
    return ThemeManager(
      defaultBrightnessPreference: BrightnessPreference.light,
      data: (Brightness brightness) => ThemeData(
        brightness: brightness,
      ),
      loadBrightnessOnStart: true,
      themedWidgetBuilder: (BuildContext context, ThemeData theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          title: 'Pati Sever',
          theme: theme,
          home: BottomNavigationBarPage(),
          initialRoute:
              initScreen == 0 || initScreen == null ? 'onboard' : 'loading',
          routes: {
            'loading': (context) => LoadingPage(),
            'onboard': (context) => OnboardingPage(),
            'login': (context) => LoginPage(),
            'register': (context) => RegisterPage(),
            '/bottomnavigationbar': (context) => BottomNavigationBarPage(),
            'mamabagıs': (context) => MamaPage(),
            'resetpasswordpage': (context) => ResetPasswordPage(),
            'newpostpage': (context) => NewPostPage(),
            'profilepage': (context) => ProfilePage(),
            'accountsettings': (context) => AccountSettings(),
            'emailverificationpage': (context) => EmailVerificationPage(),
            'guide1': (context) => Guide1(),
            'categories': (context) => CategoriesPage(),
            'patinews': (context) => PatiNews(),
          },
        );
      },
    );
  }
}
