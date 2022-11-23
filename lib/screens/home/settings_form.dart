import 'package:brew_crew/models/pengguna.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/models/pengguna_data.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ["0", "1", "2", "3", "4"];

  // form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Pengguna>(context);

    return StreamBuilder<PenggunaData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PenggunaData? penggunaData = snapshot.data;

            return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const Text("Update your brew settings!"),
                    const SizedBox(
                      height: 20.0,
                    ),

                    // name
                    TextFormField(
                      initialValue: penggunaData?.name,
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val!.isEmpty ? "Please enter a name" : null,
                      onChanged: (val) => setState(() {
                        _currentName = val;
                      }),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    // dropDown
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentSugars ?? penggunaData?.sugars,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text("$sugar sugars"),
                        );
                      }).toList(),
                      onChanged: (val) => _currentSugars = val!,
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),

                    // slider
                    Slider(
                      value: (_currentStrength ?? penggunaData!.strength)!
                          .toDouble(),
                      min: 100,
                      max: 900,
                      divisions: 8,
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round()),
                      activeColor: Colors
                          .brown[(_currentStrength ?? penggunaData?.strength)!],
                      inactiveColor: Colors
                          .brown[(_currentStrength ?? penggunaData?.strength)!],
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        /*print(_currentName);
                        print(_currentSugars);
                        print(_currentStrength);*/

                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              (_currentSugars ?? penggunaData?.sugars)!,
                              (_currentName ?? penggunaData?.name)!,
                              (_currentStrength ?? penggunaData?.strength)!
                          );
                          
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ));
          } else {
            return const Loading();
          }
        });
  }
}
