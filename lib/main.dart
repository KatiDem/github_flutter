import 'package:flutter/material.dart';

import 'presentation/app.dart';
import 'presentation/di/app_injector.dart';

void main() {
  initAppInjector();
  runApp(const MyApp());
}
