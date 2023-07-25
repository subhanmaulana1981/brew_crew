import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/pengguna.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // from provider state management
    final pengguna = Provider.of<Pengguna>(context);
    
    // return either Home or Authenticate widget
    // print("id pengguna dari wrapper: ${pengguna.uid}");
    if (pengguna.uid == "" || pengguna.uid == "Pengguna belum sign-in") {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
