import 'package:alamri_adm/al_amri.dart';
import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AlAmriEnjection().init();
  runApp(const AlAmri());
}
