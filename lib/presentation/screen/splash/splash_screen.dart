import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_api/presentation/base/bloc_screen.dart';
import 'package:github_api/presentation/screen/splash/splash_bloc.dart';

import '../../navigation/base_page.dart';
import '../../utils/colors.dart';
import '../../utils/typography.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const _routeName = '/SplashScreen';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const SplashScreen(),
      );

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BlocScreenState<SplashScreen, SplashBloc> {
  // todo: move Strings to locales file
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryAccentColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Search App',
              style: AppTextStyle.header(color: AppColors.layerColor),
            ),
            SizedBox(height: 16),
            CupertinoActivityIndicator(color: AppColors.layerColor),
          ],
        ),
      ),
    );
  }
}
