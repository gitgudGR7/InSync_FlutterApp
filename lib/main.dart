import 'package:flutter/material.dart';
import 'package:insync/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:insync/view/app_structure.dart';
import 'package:insync/view/auth/authorization.dart';
import 'package:insync/utils/theme_config.dart';
import 'package:insync/view/community/discover_community.dart';
import 'package:insync/view/home/onboarding.dart';
import 'package:insync/view/onboarding/selectinterest.dart';
import 'package:insync/view/profile/aboutus.dart';
import 'package:insync/view/profile/change_intrests.dart';
import 'package:insync/view/profile/edit_profile.dart';
import 'package:insync/view/splash.dart';
import 'dart:async';
import 'package:stacked_themes/stacked_themes.dart';

Future main() async {
  await ThemeManager.initialise();
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? theme;
  ThemeMode? thememode;

  @override
  void initState() {
    // initialization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      defaultThemeMode: ThemeMode.light,
      lightTheme: lighttheme,
      darkTheme: darktheme,
      // themes: getThemes(),
      builder: (context, lightTheme, darkTheme, themeMode) {
        return MaterialApp(
          // routes
          routes: {
            '/authorization': (context) => const Authorization(),
            '/mainapp': (context) => const MainApp(),
            '/editprofile': (context) => const EditProfile(),
            '/aboutus': (context) => const AboutUs(),
            '/discover': (context) => const DiscoverCommunity(),
            '/interests': (BuildContext context) => const Addinterests(),
            '/changeinterests': (BuildContext context) => const ChangeInterests(),
            '/onboarding/1': (BuildContext context) => const Onboardingpage1(),
            '/onboarding/2': (BuildContext context) => const Onboardingpage2(),
            '/onboarding/3': (BuildContext context) => const Onboardingpage3(),
            
          },
          title: 'InSync',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: const InSync(),
          debugShowCheckedModeBanner: false,
          // themeMode: Provider.of<ThemeNotifier>(context).currentTheme,
        );
      },
    );
  }
}

class InSync extends StatefulWidget {
  const InSync({Key? key}) : super(key: key);

  @override
  State<InSync> createState() => _InSyncState();
}

class _InSyncState extends State<InSync> {
  startTimeout() {
    return Timer(const Duration(milliseconds: 2200), handleTimeout);
  }

  void handleTimeout() {
    changeScreen();
  }

  changeScreen() async {
    bool? auth = await Constants.retrieveAuthPref();
    if (auth == true) {
      Navigator.pushNamed(context, '/mainapp');
    } else {
      Navigator.pushNamed(context, '/authorization');
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context) => const Onboarding()),
      // );
    }
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
    initialization();
  }

  void initialization() async {
    setState(() {});
    // FlutterNativeSplash.remove();
    Constants.themeSystemPref();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return const Splash();
  }
}
