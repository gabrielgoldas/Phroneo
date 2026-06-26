import 'package:flutter/cupertino.dart';
import 'package:phroneo/l10n/app_localizations.dart';

extension LocalizationBuildContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}