import 'package:github_api/domain/model/data_model.dart';

import '../../presentation/model/repos.dart';
import '../repository/github_repository.dart';
import 'usecase.dart';

class GetReposUseCase implements UseCaseParams<String, Future<List<Repo>?>> {
  final GithubApiRepository _repository;

  GetReposUseCase(
    this._repository,
  );

  @override
  Future<List<Repo>?> call(String name) async {
    final GetRepositoriesDataResponse? response = await _repository.getRepositoriesData(name);
    final List<Repo>? repos = response?.names?.map((name) => Repo(name, false)).toList();
    return repos;
  }
}
