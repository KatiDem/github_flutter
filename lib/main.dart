import 'package:flutter/material.dart';

import 'presentation/app/app.dart';
import 'presentation/di/app_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppInjector();
  runApp(const MyApp());
}
