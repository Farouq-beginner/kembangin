import '../models/product.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void add(Product product) {
    final index = _cartItems.indexWhere((p) => p.name == product.name);
    if (index >= 0) {
      _cartItems[index].quantity += product.quantity;
    } else {
      _cartItems.add(product);
    }
  }

  void removeAt(int index) => _cartItems.removeAt(index);

  void clearCart() => _cartItems.clear();
}
