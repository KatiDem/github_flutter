import 'package:flutter/material.dart';
import 'package:github_api/presentation/screen/search/search_bloc.dart';
import 'package:github_api/presentation/screen/search/search_data.dart';
import 'package:github_api/presentation/utils/icons.dart';
import 'package:github_api/presentation/utils/typography.dart';
import 'package:github_api/presentation/utils/widgets/search_card.dart';

import '../../base/bloc_data.dart';
import '../../base/bloc_screen.dart';
import '../../model/repos.dart';
import '../../navigation/base_arguments.dart';
import '../../navigation/base_page.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/app_bar.dart';
import '../../utils/widgets/button.dart';
import '../../utils/widgets/search_box.dart';

class SearchScreenArguments extends BaseArguments {
  SearchScreenArguments({
    Function(dynamic value)? result,
  }) : super(result: result);
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const _routeName = '/SearchScreen';

  static BasePage page(SearchScreenArguments arguments) => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const SearchScreen(),
        arguments: arguments,
      );

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends BlocScreenState<SearchScreen, SearchBloc> {
  _SearchScreenState();

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
    final screenSize = MediaQuery.sizeOf(context);
    return StreamBuilder<BlocData<SearchData?>>(
        stream: bloc.dataStream,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data != null) {
            final blocData = data.data;
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                appBar: CustomAppBar(
                  title: 'Github repos list',
                  action: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: AppIconButton(
                      icon: AppIcons.star,
                      onPressed: bloc.goToFavorites,
                    ),
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    SearchBox(
                      controller: bloc.controller,
                      onSearch: bloc.onSearch,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        (blocData?.reposList != null && blocData!.reposList!.isNotEmpty)
                            ? 'What we have found'
                            : 'Search history',
                        style: const AppTextStyle.header(color: AppColors.primaryAccentColor),
                      ),
                    ),
                    (blocData?.reposList != null && blocData!.reposList!.isNotEmpty)
                        ? Expanded(
                            child: Padding(
                              padding:  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: blocData.reposList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final Repo repo = blocData.reposList[index];
                                  return SearchCard(
                                    title: repo.repoName,
                                    isActive: repo.isFavorite,
                                    onFavoritePressed: () => bloc.onFavoritePressed(repo),
                                  );
                                },
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: screenSize.height * 0.25),
                            child: Center(
                              child: Text(
                                bloc.controller.text.isEmpty
                                    ? 'You have empty history.\nClick on search to start journey!'
                                    : 'Nothing was find for your search.\nPlease check the spelling',
                                style: const AppTextStyle.body(color: AppColors.placeholderTextColor),
                                textAlign: TextAlign.center,
                              ),
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
        });
  }
}
