import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../models/product.dart';
import '../../services/cart_service.dart';
import '../../services/favorite_service.dart';
import '../../pages/cart_page.dart';
import '../../pages/favorite_page.dart';

class GiftBoxPage extends StatefulWidget {
  final User currentUser;

  const GiftBoxPage({
    super.key,
    required this.currentUser,
  });

  @override
  State<GiftBoxPage> createState() => _GiftBoxPageState();
}

class _GiftBoxPageState extends State<GiftBoxPage> {
  final List<Map<String, String>> products = [
    {
      "name": "GiftBox Mawar Merah",
      "price": "Rp 185.000",
      "image": "assets/images/gift_box (1).jpg",
      "stock": "Tersedia: 10 pcs",
      "description": "GiftBox berisi mawar merah segar, cocok untuk hadiah spesial."
    },
    {
      "name": "GiftBox Coklat & Boneka",
      "price": "Rp 195.000",
      "image": "assets/images/gift_box (2).jpg",
      "stock": "Tersedia: 8 pcs",
      "description":
          "GiftBox berisi boneka lucu dan aneka coklat manis, cocok untuk pasangan."
    },
    {
      "name": "GiftBox Snack Premium",
      "price": "Rp 100.000",
      "image": "assets/images/gift_box (3).jpg",
      "stock": "Tersedia: 6 pcs",
      "description": "GiftBox berisi berbagai snack dan hadiah menarik."
    },
    {
      "name": "GiftBox Lavender + mini buket",
      "price": "Rp 135.000",
      "image": "assets/images/gift_box (4).jpg",
      "stock": "Tersedia: 10 pcs",
      "description": "GiftBox berisi bunga kering lavender dan boneka mini."
    },
    {
      "name": "GiftBox Teddy Red",
      "price": "Rp 100.000",
      "image": "assets/images/gift_box (5).jpg",
      "stock": "Tersedia: 9 pcs",
      "description": "GiftBox dengan boneka teddy bear dan bunga merah cantik."
    },
    {
      "name": "GiftBox Bunga Transparan",
      "price": "Rp 180.000",
      "image": "assets/images/gift_box (6).jpg",
      "stock": "Tersedia: 7 pcs",
      "description": "GiftBox unik dengan kemasan bunga transparan elegan."
    },
    {
      "name": "GiftBox Eksklusif",
      "price": "Rp 150.000",
      "image": "assets/images/gift_box (7).jpg",
      "stock": "Tersedia: 4 pcs",
      "description": "GiftBox eksklusif berisi bunga, coklat, dan dekorasi cantik. (Harga belum termasuk emas)"
    },
  ];

  void _addToCart(Map<String, String> product) {
    final price = int.tryParse(
          product['price']!.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    final stock = int.tryParse(
          product['stock']!.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;

    final newProduct = Product(
      name: product['name'] ?? 'Produk Tanpa Nama',
      price: price,
      image: product['image'] ?? 'assets/images/beflorist.png',
      description: product['description'] ?? '',
      stock: stock,
      quantity: 1,
    );

    CartService().add(newProduct);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${newProduct.name} ditambahkan ke keranjang 🛒"),
        backgroundColor: Colors.pink[300],
      ),
    );
  }

  void _addToFavorite(Map<String, String> product) {
    final favoriteProduct = Product(
      name: product['name'] ?? 'Produk Tanpa Nama',
      price:
          int.tryParse(product['price']!.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
      image: product['image'] ?? 'assets/images/beflorist.png',
      description: product['description'] ?? '',
      stock:
          int.tryParse(product['stock']!.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
      quantity: 1,
    );

    FavoriteService().add(favoriteProduct);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text("${favoriteProduct.name} berhasil ditambahkan ke favorite ❤️"),
        backgroundColor: Colors.pink[300],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GiftBox',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[200],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            product['image'] ?? 'assets/images/beflorist.png',
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          product['name'] ?? "Produk Tanpa Nama",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product['price'] ?? "-",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          product['stock'] ?? "Stok belum tersedia",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product['description'] ?? "Deskripsi belum tersedia",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            _addToCart(product);
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.shopping_cart),
                          label: const Text("Tambah ke Keranjang"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[300],
                            minimumSize: const Size(200, 50),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                },
              );
            },
            child: Card(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.asset(
                        product['image'] ?? "assets/images/beflorist.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product['name'] ?? "Produk Tanpa Nama",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product['price'] ?? "-",
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Tombol Favorite tiap produk
                        IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.pink),
                          onPressed: () => _addToFavorite(product),
                        ),
                        // Tombol Keranjang tiap produk
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart,
                              color: Colors.pink),
                          onPressed: () => _addToCart(product),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}