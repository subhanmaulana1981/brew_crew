import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // authentication service
  final AuthService _auth = AuthService();

  // validate with form key
  final _formKey = GlobalKey<FormState>();

  // spinner loading widget
  bool loading = false;

  // text field state
  String? email;
  String? password;
  String? error;

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? const Loading()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: const Text("Sign up to Brew Crew"),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: const Icon(Icons.login),
                  tooltip: "Signin",
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                width: 542,
                height: 805,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/coffee_bg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: "Email"),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please enter your email!";
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Password"),
                          validator: (val) {
                            if (val == null || val.length < 6) {
                              return "Enter a password 6+ chars long!";
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ButtonBar(
                            alignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // print(email);
                                    // print(password);
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email!, password!);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error =
                                            "Please supply a valid email and password!";
                                      });
                                    }
                                  }
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "$error!",
                          style: TextStyle(
                            color:
                                error == null ? Colors.brown[100] : Colors.red,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          );
  }
}
