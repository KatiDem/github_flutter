import 'package:github_api/presentation/model/repos.dart';

class SearchData {
  List<Repo> reposList;

  List<dynamic>? reposNames;
  bool isEmptyRepos;

  SearchData(this.reposList, this.reposNames, this.isEmptyRepos);

  factory SearchData.init() => SearchData(
        [],
        null,
        false,
      );

  SearchData copy() => SearchData(
        reposList,
        reposNames,
        isEmptyRepos,
      );
}
