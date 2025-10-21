import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../models/product.dart';
import '../../services/cart_service.dart';
import '../../services/favorite_service.dart';
import '../../pages/cart_page.dart';
import '../../pages/favorite_page.dart';

class HampersPage extends StatefulWidget {
  final User currentUser;

  const HampersPage({
    super.key,
    required this.currentUser,
  });

  @override
  State<HampersPage> createState() => _HampersPageState();
}

class _HampersPageState extends State<HampersPage> {
  final List<Map<String, String>> products = [
    {
      "name": "Hampers Piring Coklat",
      "price": "Rp 350.000",
      "image": "assets/images/hampers (1).jpg",
      "stock": "Tersedia: 10 pcs",
      "description": "Hampers dengan kemasan cantik berisi berbagai snack pilihan."
    },
    {
      "name": "Hampers Snack 1",
      "price": "Rp 230.000",
      "image": "assets/images/hampers (2).jpg",
      "stock": "Tersedia: 12 pcs",
      "description": "Hampers spesial berisi kue kering dan coklat premium."
    },
    {
      "name": "Hampers Snack 2",
      "price": "Rp 200.000",
      "image": "assets/images/hampers (3).jpg",
      "stock": "Tersedia: 8 pcs",
      "description": "Cocok untuk hadiah ulang tahun dan perayaan kecil."
    },
    {
      "name": "Hampers Set Cangkir",
      "price": "Rp 280.000",
      "image": "assets/images/hampers (4).jpg",
      "stock": "Tersedia: 15 pcs",
      "description": "Hampers elegan berisi minuman dan snack ringan."
    },
    {
      "name": "Hampers Piring + Nastar",
      "price": "Rp 250.000",
      "image": "assets/images/hampers (5).jpg",
      "stock": "Tersedia: 6 pcs",
      "description": "Hampers bunga dan coklat, romantis dan eksklusif."
    },
    {
      "name": "Hampers Snack 3",
      "price": "Rp 260.000",
      "image": "assets/images/hampers (6).jpg",
      "stock": "Tersedia: 7 pcs",
      "description": "Berisi snack impor dan dekorasi eksklusif."
    },
    {
      "name": "Hampers Set Cangkir + Snack",
      "price": "Rp 450.000",
      "image": "assets/images/hampers (7).jpg",
      "stock": "Tersedia: 10 pcs",
      "description": "Hampers elegan berisi aneka makanan ringan pilihan."
    },
    {
      "name": "Hampers All Set Alat Makan + Nastar",
      "price": "Rp 320.000",
      "image": "assets/images/hampers (8).jpg",
      "stock": "Tersedia: 8 pcs",
      "description": "Hampers spesial dengan dekorasi mewah dan isi lengkap."
    },
    {
      "name": "Hampers All Set Alat Makan Biru",
      "price": "Rp 360.000",
      "image": "assets/images/hampers (9).jpg",
      "stock": "Tersedia: 5 pcs",
      "description": "Berisi coklat dan bunga segar, cocok untuk hadiah romantis."
    },
    {
      "name": "Hampers Mangkuk + Nastar",
      "price": "Rp 220.000",
      "image": "assets/images/hampers (10).jpg",
      "stock": "Tersedia: 9 pcs",
      "description": "Hampers dengan kombinasi makanan ringan dan minuman."
    },
    {
      "name": "Hampers Piring Biru",
      "price": "Rp 250.000",
      "image": "assets/images/hampers (11).jpg",
      "stock": "Tersedia: 7 pcs",
      "description": "Hampers eksklusif untuk acara spesial."
    },
    {
      "name": "Hampers Piring Pink",
      "price": "Rp 260.000",
      "image": "assets/images/hampers (12).jpg",
      "stock": "Tersedia: 6 pcs",
      "description": "Hampers elegan dengan kombinasi coklat dan snack manis."
    },
    {
      "name": "Hampers Snack 4",
      "price": "Rp 210.000",
      "image": "assets/images/hampers (13).jpg",
      "stock": "Tersedia: 10 pcs",
      "description": "Hampers premium dengan isi lengkap untuk keluarga."
    },
    {
      "name": "Hampers All Set Alat Makan Coklat",
      "price": "Rp 340.000",
      "image": "assets/images/hampers (14).jpg",
      "stock": "Tersedia: 4 pcs",
      "description": "Hampers eksklusif dengan kemasan cantik dan isi mewah."
    },
    {
      "name": "Hampers Piring Merah",
      "price": "Rp 300.000",
      "image": "assets/images/hampers (15).jpg",
      "stock": "Tersedia: 3 pcs",
      "description": "Hampers spesial premium untuk momen berharga."
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
      image: product['image'] ?? 'assets/images/placeholder.png',
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
      image: product['image'] ?? 'assets/images/placeholder.png',
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
          'Hampers',
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
                            product['image'] ?? 'assets/images/placeholder.png',
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
                        product['image'] ?? "assets/images/placeholder.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
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