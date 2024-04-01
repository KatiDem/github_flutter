import '../model/data_model.dart';

abstract class GithubApiRepository {
  Future<GetRepositoriesDataResponse?> getRepositoriesData(
    String name, {
    int itemCount = 15,
  });
}
