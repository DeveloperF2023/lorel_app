import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';
import 'package:school_test_online/features/presentation/pages/language/language_screen.dart';
import 'package:school_test_online/features/presentation/pages/main/main_screen.dart';
import 'package:school_test_online/features/presentation/widgets/auth/widgets_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../manager/user/auth/auth_cubit.dart';
import '../../manager/user/credential/credential_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSigningIn = false;
  Locale _locale = const Locale("en");
  void _changeLanguage(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', locale.languageCode); // Save language code
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LanguageScreen(
              onLocaleChange: _changeLanguage,
            ),
          ),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<CredentialCubit, CredentialState>(
          listener: (context, credentialState) {
            if (credentialState is CredentialSuccess) {
              BlocProvider.of<AuthCubit>(context).loggedIn();
              setState(() {
                _isSigningIn = true;
              });
              print("Login successful, transitioning to main screen");
            } else if (credentialState is CredentialLoading) {
              print("Credential loading...");
              const CircularProgressIndicator();
            } else if (credentialState is CredentialFailure) {
              setState(() {
                _isSigningIn = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocalization.of(context)!
                    .translate("incorrectPassword")),
              ));
              print("Login failed ${credentialState.message}");
            }
          },
          builder: (context, credentialState) {
            if (credentialState is CredentialSuccess) {
              debugPrint("this is state $credentialState");
              return BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, authState) {
                if (authState is Authenticated && authState.userToken != null) {
                  print(
                      "Authenticated state detected, redirecting to MainScreen");
                  return MainScreen(
                    token: authState.userToken!,
                  );
                } else {
                  return LoginContent(
                    isSignIn: _isSigningIn,
                  );
                }
              });
            }
            return LoginContent(
              isSignIn: _isSigningIn,
            );
          },
        ),
      ),
    );
  }
}
