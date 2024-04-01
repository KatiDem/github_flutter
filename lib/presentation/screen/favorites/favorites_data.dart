class FavoritesData {
  List<String> names;

  FavoritesData(this.names);

  factory FavoritesData.init() => FavoritesData([]);

  FavoritesData copy() => FavoritesData(names);
}
