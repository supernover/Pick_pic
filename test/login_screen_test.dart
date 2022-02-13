import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mockito/mockito.dart';
import 'package:pick_pic/components/my_common_button.dart';
import 'package:pick_pic/widgets/login/components/my_login_button.dart';
import 'package:pick_pic/widgets/login/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'util/mock_firebase_app.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  setupFirebaseAuthMocks();
  final mockObserver = MockNavigatorObserver();
  String widgetTag = 'Login';
  late MockGoogleSignIn googleSignIn;
  setUp(() async {
    HttpOverrides.global = null;
    await Firebase.initializeApp();
    googleSignIn = MockGoogleSignIn();
  });

  MediaQuery testApp = MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
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
        home: ProviderScope(child: LoginScreen()),
        navigatorObservers: [mockObserver],
      ));

  testWidgets('Verify widget', (WidgetTester tester) async {
    await tester.pumpWidget(testApp);
    expect(find.byKey(Key('body')), findsOneWidget);
    expect(find.byKey(Key('loginButton')), findsOneWidget);
    await tester.tap(find.byKey(Key('loginButton')));
    // await tester.pumpAndSettle();
    // // // verify(mockObserver.didPush(any, any));
    expect(find.byType(MyCommonButton), findsOneWidget);
    StreamController<User> controller = StreamController<User>();
    final user = MockUser(
      isAnonymous: false,
      uid: 'testUID',
      email: 'test@somedomain.com',
      displayName: 'test',
    );
    controller.add(user);

    await tester.pumpWidget(MaterialApp(
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
            child: MyLoginButton(
          loginTag: 0001,
          stream: controller.stream,
        ))));

    Finder waiting = find.byKey(Key('loginLoading'));
    expect(waiting, findsOneWidget);
    await tester.pump(Duration.zero);

    Finder success = find.byKey(Key('loginSuccess'));
    expect(success, findsOneWidget);
  });
}
