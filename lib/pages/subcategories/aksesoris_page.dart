import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../models/product.dart';
import '../../services/cart_service.dart';
import '../../services/favorite_service.dart';
import '../../pages/cart_page.dart';
import '../../pages/favorite_page.dart';

class AksesorisPage extends StatefulWidget {
  final User currentUser;

  const AksesorisPage({
    super.key,
    required this.currentUser,
  });

  @override
  State<AksesorisPage> createState() => _AksesorisPageState();
}

class _AksesorisPageState extends State<AksesorisPage> {
  final List<Map<String, String>> products = [
    {
      "name": "Vas Kaca",
      "price": "Rp 50.000",
      "image": "assets/images/vas_kaca.jpg",
      "stock": "Tersedia: 15 pcs",
      "description": "Vase kaca elegan, cocok untuk menampilkan buket bunga favoritmu."
    },
    {
      "name": "Pita",
      "price": "Rp 10.000",
      "image": "assets/images/pita.jpg",
      "stock": "Tersedia: 50 pcs",
      "description": "Pita hias cantik untuk membungkus buket atau hampers."
    },
    {
      "name": "Kertas Buket",
      "price": "Rp 5.000",
      "image": "assets/images/kertas_buket.jpg",
      "stock": "Tersedia: 100 pcs",
      "description": "Dekorasi kertas warna-warni, mempercantik buket bunga."
    },
    {
      "name": "Kotak Hadiah",
      "price": "Rp 30.000",
      "image": "assets/images/kotak_hadiah.jpg",
      "stock": "Tersedia: 25 pcs",
      "description": "Kotak hadiah berkualitas, siap untuk menyimpan buket atau aksesoris."
    },
    {
      "name": "Ribbon Satin",
      "price": "Rp 15.000",
      "image": "assets/images/ribbon_satin.jpg",
      "stock": "Tersedia: 40 pcs",
      "description": "Ribbon satin lembut, menambah kesan elegan pada dekorasi bunga."
    },
    {
      "name": "Bunga Kering Mini",
      "price": "Rp 12.000",
      "image": "assets/images/bunga_kering.jpg",
      "stock": "Tersedia: 60 pcs",
      "description": "Bunga kering mini cantik, bisa dijadikan dekorasi meja atau hiasan dinding."
    },
    {
      "name": "Keranjang Rotan",
      "price": "Rp 35.000",
      "image": "assets/images/keranjang_rotan.jpg",
      "stock": "Tersedia: 20 pcs",
      "description": "Keranjang rotan serbaguna, cocok untuk menyimpan bunga atau hadiah."
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
          'Aksesoris',
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