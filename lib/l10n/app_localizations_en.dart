// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Phroneo';

  @override
  String get login => 'Login';

  @override
  String get create_room => 'Create Room';

  @override
  String get login_google => 'Sign in with Google';

  @override
  String get privacy_policy => 'Select your account here. \nBy signing in, you agree to our privacy policy';

  @override
  String get ready => 'Ready!';

  @override
  String get next => 'Next';

  @override
  String get previous => 'Prev';

  @override
  String get welcome_message => 'Let\'s play?';

  @override
  String get create_match => 'Create a match';

  @override
  String get join_match => 'Join match';

  @override
  String get confirm_creation => 'Create';

  @override
  String get player_count_question => 'How many players?';

  @override
  String get profile => 'My profile';

  @override
  String get how_to_play => 'How to play';

  @override
  String get exit => 'Log out';
}
