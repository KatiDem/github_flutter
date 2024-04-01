class Repo {
  final String repoName;
  bool isFavorite;

  Repo(
    this.repoName,
    this.isFavorite,
  );

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}
