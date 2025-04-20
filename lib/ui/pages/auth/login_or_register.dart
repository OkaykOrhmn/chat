import 'package:chat/core/gen/assets.gen.dart';
import 'package:chat/core/services/auth_services.dart';
import 'package:chat/core/utils/empty_space.dart';
import 'package:chat/data/enum/state_handler.dart';
import 'package:chat/data/storage/shared_preferences_helper.dart';
import 'package:chat/ui/pages/auth/cubit/auth_cubit.dart';
import 'package:chat/ui/pages/auth/login_screen.dart';
import 'package:chat/ui/pages/auth/provider/user_provider.dart';
import 'package:chat/ui/pages/auth/reggister_screen.dart';
import 'package:chat/ui/widgets/buttons.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool inRegister = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  void toggleRegister() {
    setState(() {
      inRegister = !inRegister;
    });
  }

  Future onConfirm() async {
    final AuthServices authServices = AuthServices();
    if (_emailController.text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Email is required',
            style: TextStyle(color: Colors.red),
          ),
        ));
      }
      return;
    }
    if (_passwordController.text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Password is required',
            style: TextStyle(color: Colors.red),
          ),
        ));
      }
      return;
    }
    if (inRegister && _confirmPasswordController.text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Confirm Password is required',
            style: TextStyle(color: Colors.red),
          ),
        ));
      }
      return;
    }
    try {
      if (inRegister) {
        await authServices.signUpWithEmail(
            email: _emailController.text, password: _passwordController.text);
      } else {
        await authServices.signInWithEmail(
            email: _emailController.text, password: _passwordController.text);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            e.toString(),
            style: const TextStyle(color: Colors.red),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dividerColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade800
        : Colors.grey.shade300; // Define your divider color here
    // Remove underline from TextStyle
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: DividerThemeData(
          color: Colors.transparent,
        ),
      ),
      child: Scaffold(
        persistentFooterButtons: [
          SizedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: dividerColor,
                    )),
                    Text('Or'),
                    Expanded(
                        child: Divider(
                      color: dividerColor,
                    ))
                  ],
                ),
                8.h,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Buttons(context)
                      .primary(text: 'GOOGLE', onPressed: () {}),
                ),
              ],
            ),
          )
        ],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                children: [
                  Flexible(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.sizeOf(context).height * 0.4,
                      ),
                      child: Assets.images.loginHeaderPng.image(
                        width: MediaQuery.sizeOf(context).width,
                        color: Theme.of(context).colorScheme.primary,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0), // Adjust this value for padding
                          child: Text(
                            inRegister ? 'Register' : 'Login',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration
                                      .none, // Remove underline from TextStyle
                                ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            height: 4, // Thickness of the underline
                            color: Theme.of(context)
                                .colorScheme
                                .primary, // Color of the underline
                            child: Opacity(
                              opacity: 0,
                              child: Text(
                                inRegister ? 'Register' : 'Login',
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AnimatedCrossFade(
                      firstChild: ReggisterScreen(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                      ),
                      secondChild: LoginScreen(
                        emailController: _emailController,
                        passwordController: _passwordController,
                      ),
                      crossFadeState: inRegister
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 300),
                      layoutBuilder:
                          (topChild, topKey, bottomChild, bottomKey) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Stack(
                          children: <Widget>[
                            bottomChild,
                            topChild,
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
              child: Column(
                children: [
                  BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                    if (state is AuthAuthenticated) {
                      final token = state.auth.token;
                      if (token != null) {
                        AuthTokenStorage.setToken(token);
                      }
                      context.read<UserProvider>().checkMyInformation();
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ));
                    }
                  }, builder: (context, authState) {
                    return Consumer<UserProvider>(
                        builder: (context, userProvider, child) {
                      return Buttons(context).primary(
                        text: inRegister ? 'Register' : 'Login',
                        isLoading: authState is AuthLoading ||
                            userProvider.userState == StateHandler.loading,
                        onPressed: () async {
                          if (inRegister) {
                            context.read<AuthCubit>().signUp(
                                username: _emailController.text,
                                password: _passwordController.text);
                          } else {
                            context.read<AuthCubit>().signIn(
                                username: _emailController.text,
                                password: _passwordController.text);
                          }
                        },
                      );
                    });
                  }),
                  16.h,
                  Text.rich(TextSpan(
                      text: 'Already have an Account! ',
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: !inRegister ? 'Register' : 'Login',
                          recognizer: TapGestureRecognizer()
                            ..onTap = toggleRegister,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary),
                        )
                      ])),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
