import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: AuthenticationGate(),
  );
}

class AuthenticationGate extends StatelessWidget {
  const AuthenticationGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      // User is not signed in - show a sign-in screen
      if (!snapshot.hasData) {
        return SignInScreen(
          providerConfigs: [
            EmailProviderConfiguration(),
            GoogleProviderConfiguration(
              clientId: 'xxxx-xxxx.apps.googleusercontent.com',
            ),
          ],
        );
      }

      return HomePage(); // show your app’s home page after login
    },
  );
}