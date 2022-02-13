import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_pic/routes/route_name.dart';
import 'package:pick_pic/widgets/login/login_screen.dart';
import 'package:pick_pic/widgets/main/main_page.dart';
import 'package:pick_pic/widgets/puzzle/puzzle_list_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'common/constants.dart';
import 'package:intl/intl.dart';

/// use for DarkMode,not sync  with system
final DarkModeProvider = StateProvider((ref) => false);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  void initApp(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    /// init
    initApp(context);
    return Consumer(
      builder: (context, watch, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            AppLocalizations.delegate, // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''), // English, no country code
            const Locale('ja', ''), // Japanese, no country code
          ],
          title: 'pick Pic Puzzle',
          initialRoute: RouteName.Login,
          routes: {
            RouteName.Login: (context) => LoginScreen(),
            RouteName.Main: (context) => MainPage(),
            RouteName.Home: (context) => PuzzleListPage(),
          },
          theme: watch(DarkModeProvider).state ? darkTheme : lightTheme,
          // darkTheme: darkTheme,
        );
      },
    );
  }
}
