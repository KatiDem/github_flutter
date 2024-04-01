import 'package:github_api/domain/model/data_model.dart';

import '../../domain/repository/github_repository.dart';
import '../service/api_base_service.dart';
import '../service/service_payload.dart';

class GithubAPIRepositoryImpl implements GithubApiRepository {
  final ApiBaseService<ServicePayload> _apiService;

  GithubAPIRepositoryImpl(this._apiService);

  @override
  Future<GetRepositoriesDataResponse?> getRepositoriesData(
    String name, {
    int itemCount = 15,
  }) async {
    final path = '/search/repositories?q=$name+in:name&sort=stars&page=1&per_page=15';
    final names = <String>[];
    final response = await _apiService.get(
      path,
    );
    if (response.statusCode == 200) {
      final List<dynamic> repositories = response.data['items'];

      List<String> searchResult = repositories.map((repo) => repo['name'].toString()).toList();
      names.addAll(searchResult);
    }

    return GetRepositoriesDataResponse(
      names: names.isEmpty ? null : names,
    );
  }
}
