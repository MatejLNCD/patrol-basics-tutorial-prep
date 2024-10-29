import 'package:flutter/foundation.dart';

class SignInPageKeys {
  final emailTextField = const Key('emailTextField');
  final passwordTextField = const Key('passwordTextField');
  final signInButton = const Key('signInButton');
}

class HomePageKeys {
  final notificationIcon = const Key('notificationIcon');
  final successSnackbar = const Key('successSnackbar');
}

class Keys {
  final signInPage = SignInPageKeys();
  final homePage = HomePageKeys();
}

final keys = Keys();
