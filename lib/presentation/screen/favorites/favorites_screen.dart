import 'package:flutter/material.dart';
import 'package:github_api/presentation/screen/favorites/favorites_data.dart';
import 'package:github_api/presentation/utils/widgets/app_bar.dart';

import '../../base/bloc_data.dart';
import '../../base/bloc_screen.dart';
import '../../navigation/base_arguments.dart';
import '../../navigation/base_page.dart';
import '../../utils/icons.dart';
import '../../utils/widgets/button.dart';
import '../../utils/widgets/search_card.dart';
import 'favorites_bloc.dart';

class FavoritesScreenArguments extends BaseArguments {
  FavoritesScreenArguments({
    Function(dynamic value)? result,
  }) : super(result: result);
}

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  static const _routeName = '/FavoritesScreen';

  static BasePage page(FavoritesScreenArguments arguments) => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const FavoritesScreen(),
        arguments: arguments,
      );

  @override
  State<StatefulWidget> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends BlocScreenState<FavoritesScreen, FavoritesBloc> {
  _FavoritesScreenState();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocData<FavoritesData?>>(
      stream: bloc.dataStream,
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data != null) {
          final blocData = data.data;
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Favorite repos list',
              leading: AppIconButton(
                icon: AppIcons.arrowLeft,
                onPressed: bloc.goBack,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: blocData?.names.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SearchCard(
                          title: blocData?.names[index] ?? '',
                          isActive: true,
                          onFavoritePressed: () => bloc.onFavoriteRemove(blocData?.names[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Container(),
          );
        }
      },
    );
  }
}
