import 'product.dart';

class Cart {
  static final List<Product> items = [];

  static void add(Product product) {
    final existing = items.where((p) => p.name == product.name).toList();
    if (existing.isNotEmpty) {
      existing.first.quantity += 1; // tambahkan jumlah
    } else {
      items.add(product);
    }
  }

  static void remove(Product product) {
    // Kurangi quantity, hapus kalau 0
    final existing = items.where((p) => p.name == product.name).toList();
    if (existing.isNotEmpty) {
      if (existing.first.quantity > 1) {
        existing.first.quantity -= 1;
      } else {
        items.remove(existing.first);
      }
    }
  }

  static void clear() {
    items.clear();
  }

  static int get totalItems =>
      items.fold(0, (sum, item) => sum + item.quantity);

  static int get totalPrice =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));
}
