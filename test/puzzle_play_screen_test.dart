import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart';
import 'package:pick_pic/widgets/game/display_picture_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pick_pic/widgets/puzzle/puzzle_play_page.dart';
import 'util/mock_firebase_app.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

Future<void> main() async {
  setupFirebaseAuthMocks();
  final mockObserver = MockNavigatorObserver();
  var data = await rootBundle.load('assets/images/banner.jpg');
  setUp(() async {
    HttpOverrides.global = null;
    await Firebase.initializeApp();
  });

  testWidgets('Verify widget', (WidgetTester tester) async {
    final Roboto = rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    await FontLoader('Roboto')
      ..addFont(Roboto)
      ..load();

    // Adjust these to match your actual device screen specs
    final width = 411.4;
    final height = 797.7;
    tester.binding.window.devicePixelRatioTestValue = (2.625);
    tester.binding.window.textScaleFactorTestValue = (1.1);
    final dpi = tester.binding.window.devicePixelRatio;
    tester.binding.window.physicalSizeTestValue =
        Size(width * dpi, height * dpi);

    MediaQuery testApp = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Roboto',
          ),
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate, // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''), // English, no country code
            const Locale('ja', ''), // Japanese, no country code
          ],
          home: ProviderScope(
              child:
                  PuzzlePlayPage(Size(800, 600), data.buffer.asUint8List(), 3)),
          navigatorObservers: [mockObserver],
        ));
    //
    // await tester.pumpWidget(testApp);
    // await tester.pump(new Duration(seconds: 3));
    // await tester.pumpAndSettle();
    // print('widget build');
    // expect(find.byType(Scaffold), findsOneWidget);
  });
}
