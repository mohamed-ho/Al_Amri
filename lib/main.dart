import 'package:alamri_adm/al_amri.dart';
import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SemanticsBinding.instance.ensureSemantics();
  AlAmriEnjection().init();
  runApp(const MouseRegion(child: AlAmri()));
}
