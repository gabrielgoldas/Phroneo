// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Phroneo';

  @override
  String get login => 'Login';

  @override
  String get createRoom => 'Create Room';

  @override
  String get googleLogin => 'Sign in with Google';

  @override
  String get privacyPolicy => 'Select your account here. \nBy signing in, you agree to our privacy policy';

  @override
  String get ready => 'Ready!';

  @override
  String get next => 'Next';

  @override
  String get previous => 'Prev';

  @override
  String get letsPlay => 'Let\'s play?';
}
