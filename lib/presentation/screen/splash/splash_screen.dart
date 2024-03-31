import 'package:flutter/material.dart';

import '../../navigation/base_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const _routeName = '/SplashScreen';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const SplashScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
