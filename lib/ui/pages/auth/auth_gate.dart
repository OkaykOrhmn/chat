import 'package:chat/data/enum/state_handler.dart';
import 'package:chat/ui/pages/auth/login_or_register.dart';
import 'package:chat/ui/pages/auth/provider/user_provider.dart';
import 'package:chat/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, state, child) {
          if (state.userState == StateHandler.loaded) {
            return HomePage();
          } else if (state.userState == StateHandler.error ||
              state.userState == StateHandler.empty) {
            return LoginOrRegister();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
