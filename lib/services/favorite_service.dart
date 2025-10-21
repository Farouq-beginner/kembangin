// favorite_service.dart
import '../models/product.dart';

class FavoriteService {
  static final FavoriteService _instance = FavoriteService._internal();
  factory FavoriteService() => _instance;
  FavoriteService._internal();

  final List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  void add(Product product) {
    // hindari duplikat
    if (!_favorites.any((p) => p.name == product.name)) {
      _favorites.add(product);
    }
  }

  void remove(Product product) {
    _favorites.removeWhere((p) => p.name == product.name);
  }

  void clear() {
    _favorites.clear();
  }
}
