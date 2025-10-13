import 'package:flutter/material.dart';

import 'signIn.dart';

class Authenticate extends StatefulWidget {
  Authenticate({super.key});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  // DEAD CODE
  // bool sign_in_shown = true;
  // void toggle() {
  //   setState(() => sign_in_shown = !sign_in_shown);
  // }

  @override
  Widget build(BuildContext context) {
    // DEAD CODE
    // return Container(
    //   child: sign_in_shown
    //       ? SignIn(toggleview: toggle)
    //       : Register(toggleView: toggle),
    // );
    return SignIn();
  }
}
