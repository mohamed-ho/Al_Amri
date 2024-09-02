import 'package:alamri_adm/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';

String getTranslation(String key, BuildContext context) {
  return AppLocalizations.of(context)!.translate(key)!;
}
