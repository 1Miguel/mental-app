import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/ui_views/book_appointment.dart';
import 'package:flutter_intro/ui_views/sound_player.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'ui_views/login_views.dart';
import 'ui_views/admin_navigation_views.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _requireConsent = false;
  String _debugLabelString = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;

    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.Debug.setAlertLevel(OSLogLevel.none);
    OneSignal.consentRequired(_requireConsent);
    OneSignal.Notifications.requestPermission(true);

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    OneSignal.initialize("b44afb89-b2cb-4382-96a2-edac8b13caa9");

    // AndroidOnly stat only
    // OneSignal.Notifications.removeNotification(1);
    // OneSignal.Notifications.removeGroupedNotifications("group5");

    OneSignal.Notifications.clearAll();

    OneSignal.User.pushSubscription.addObserver((state) {
      print(OneSignal.User.pushSubscription.optedIn);
      print(OneSignal.User.pushSubscription.id);
      print(OneSignal.User.pushSubscription.token);
      print(state.current.jsonRepresentation());
    });

    OneSignal.Notifications.addPermissionObserver((state) {
      print("Has permission " + state.toString());
    });

    OneSignal.Notifications.addClickListener((event) {
      print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
      this.setState(() {
        _debugLabelString =
            "Clicked notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
        //print(_debugLabelString);
      });
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      print(
          'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');

      /// Display Notification, preventDefault to not display
      event.preventDefault();

      /// Do async work

      /// notification.display() to display after preventing default
      event.notification.display();

      this.setState(() {
        _debugLabelString =
            "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.InAppMessages.addClickListener((event) {
      this.setState(() {
        _debugLabelString =
            "In App Message Clicked: \n${event.result.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });
    OneSignal.InAppMessages.addWillDisplayListener((event) {
      print("ON WILL DISPLAY IN APP MESSAGE ${event.message.messageId}");
    });
    OneSignal.InAppMessages.addDidDisplayListener((event) {
      print("ON DID DISPLAY IN APP MESSAGE ${event.message.messageId}");
    });
    OneSignal.InAppMessages.addWillDismissListener((event) {
      print("ON WILL DISMISS IN APP MESSAGE ${event.message.messageId}");
    });
    OneSignal.InAppMessages.addDidDismissListener((event) {
      print("ON DID DISMISS IN APP MESSAGE ${event.message.messageId}");
    });

    //OneSignal.InAppMessages.paused(true);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Mental Health App',
        theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.blue,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            scaffoldBackgroundColor: Colors.white,
            platform: TargetPlatform.android),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginMainPage(),
          //'/': (context) => MySoundApp(),
          //'/': (context) => kIsWeb ? AdminApp() : LoginMainPage(),
          '/admin': (context) => AdminApp(),
        });
  }
}

class MyAppState extends ChangeNotifier {}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 250,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
        ),
      ),
    );
  }
}
