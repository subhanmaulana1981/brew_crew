
import 'package:brew_crew/models/pengguna.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<Pengguna>.value(
      value: AuthService().onAuthStateChanges,
      initialData: Pengguna(uid: ""),
      catchError: (BuildContext context, Object? exception) {
        return Pengguna(uid: "Pengguna belum sign-in");
      },
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: const Wrapper(),
      ),
    );

  }
}

