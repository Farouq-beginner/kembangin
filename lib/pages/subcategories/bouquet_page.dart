import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../models/product.dart';
import '../../services/cart_service.dart';
import '../../services/favorite_service.dart';
import '../../pages/cart_page.dart';
import '../../pages/favorite_page.dart';

class BouquetPage extends StatefulWidget {
  final User currentUser;

  const BouquetPage({super.key, required this.currentUser});

  @override
  State<BouquetPage> createState() => _BouquetPageState();
}

class _BouquetPageState extends State<BouquetPage> {
  final List<Map<String, String>> products = [

    {
      "name": "Buket Artificial Mawar Merah (Large)",
      "price": "Rp 300.000",
      "image": "assets/images/artifical_flowers (1).jpg",
      "stock": "Tersedia: 10 pcs",
      "description": "Bouquet bunga artificial yang awet dan cantik, cocok untuk dekorasi dan hadiah jangka panjang."
    },
    {
      "name": "Buket Artificial Mawar Merah (Small)",
      "price": "Rp 50.000",
      "image": "assets/images/artifical_flowers (2).jpg",
      "stock": "Tersedia: 11 pcs",
      "description": "Bouquet bunga artificial yang awet dan cantik, cocok untuk dekorasi dan hadiah jangka panjang."
    },
    {
      "name": "Buket Artificial Tulip (Small)",
      "price": "Rp 45.000",
      "image": "assets/images/artifical_flowers (3).jpg",
      "stock": "Tersedia: 9 pcs",
      "description": "Bouquet bunga artificial yang awet dan cantik, cocok untuk dekorasi dan hadiah jangka panjang."
    },
    {
      "name": "Buket Artificial Mawar (Medium)",
      "price": "Rp 70.000",
      "image": "assets/images/artifical_flowers (4).jpg",
      "stock": "Tersedia: 12 pcs",
      "description": "Bouquet bunga artificial yang awet dan cantik, cocok untuk dekorasi dan hadiah jangka panjang."
    },
    {
      "name": "Buket Artificial Mawar Mix Bried (Small)",
      "price": "Rp 80.000",
      "image": "assets/images/artifical_flowers (5).jpg",
      "stock": "Tersedia: 8 pcs",
      "description": "Bouquet bunga artificial yang awet dan cantik, cocok untuk dekorasi dan hadiah jangka panjang."
    },
    {
      "name": "Buket Artificial Mix Flowers (Medium)",
      "price": "Rp 105.000",
      "image": "assets/images/artifical_flowers (6).jpg",
      "stock": "Tersedia: 14 pcs",
      "description": "Bouquet bunga artificial yang awet dan cantik, cocok untuk dekorasi dan hadiah jangka panjang."
    },
    {
      "name": "Buket Artificial Mawar Mix Lily Putih (Medium)",
      "price": "Rp 185.000",
      "image": "assets/images/artifical_flowers (7).jpg",
      "stock": "Tersedia: 7 pcs",
      "description": "Bouquet bunga artificial yang awet dan cantik, cocok untuk dekorasi dan hadiah jangka panjang."
    },
    {
      "name": "Buket Artificial Mawar Pink (Medium)",
      "price": "Rp 100.000",
      "image": "assets/images/artifical_flowers (8).jpg",
      "stock": "Tersedia: 13 pcs",
      "description": "Bouquet bunga artificial yang awet dan cantik, cocok untuk dekorasi dan hadiah jangka panjang."
    },
    {
      "name": "Buket Artificial Mawar + Kupu Kupu",
      "price": "Rp 100.000",
      "image": "assets/images/artifical_flowers (9).jpg",
      "stock": "Tersedia: 10 pcs",
      "description": "Bouquet bunga artificial yang awet dan cantik, cocok untuk dekorasi dan hadiah jangka panjang."
    },
    {
      "name": "Buket Artificial All Mawar Mix (Medium)",
      "price": "Rp 125.000",
      "image": "assets/images/artifical_flowers (10).jpg",
      "stock": "Tersedia: 11 pcs",
      "description": "Bouquet bunga artificial yang awet dan cantik, cocok untuk dekorasi dan hadiah jangka panjang."
    },
    {
      "name": "Buket Artificial All Flowers Mix (Large)",
      "price": "Rp 230.000",
      "image": "assets/images/artifical_flowers (11).jpg",
      "stock": "Tersedia: 9 pcs",
      "description": "Bouquet bunga artificial yang awet dan cantik, cocok untuk dekorasi dan hadiah jangka panjang."
    },
    {
      "name": "Buket Artificial Mawar Hitam Mix Lily (Medium)",
      "price": "Rp 185.000",
      "image": "assets/images/artifical_flowers (13).jpg",
      "stock": "Tersedia: 8 pcs",
      "description": "Bouquet bunga artificial yang awet dan cantik, cocok untuk dekorasi dan hadiah jangka panjang."
    },
    {
      "name": "Buket Artificial Lily Mix Tulip Pink (Medium)",
      "price": "Rp 235.000",
      "image": "assets/images/artifical_flowers (14).jpg",
      "stock": "Tersedia: 12 pcs",
      "description": "Bouquet bunga artificial yang awet dan cantik, cocok untuk dekorasi dan hadiah jangka panjang."
    },
    {
      "name": "Buket Artificial Mawar pink (Large)",
      "price": "Rp 575.000",
      "image": "assets/images/artifical_flowers (15).jpg",
      "stock": "Tersedia: 7 pcs",
      "description": "Bouquet bunga artificial yang awet dan cantik, cocok untuk dekorasi dan hadiah jangka panjang."
    },
    {
      "name": "Buket 1 Coklat (Small)",
      "price": "Rp 40.000",
      "image": "assets/images/buket_coklat (1).jpg",
      "stock": "Tersedia: 8 pcs",
      "description": "Bouquet berisi coklat manis dengan hiasan cantik, cocok untuk hadiah Valentine atau ulang tahun."
    },
    {
      "name": "Buket 4 Coklat (Medium)",
      "price": "Rp 165.000",
      "image": "assets/images/buket_coklat (2).jpg",
      "stock": "Tersedia: 9 pcs",
      "description": "Bouquet berisi coklat manis dengan hiasan cantik, cocok untuk hadiah Valentine atau ulang tahun."
    },
    {
      "name": "Buket 10 Coklat (Large)",
      "price": "Rp 600.000",
      "image": "assets/images/buket_coklat (3).jpg",
      "stock": "Tersedia: 7 pcs",
      "description": "Bouquet berisi coklat manis dengan hiasan cantik, cocok untuk hadiah Valentine atau ulang tahun."
    },
    {
      "name": "Buket Coklat + Teddy",
      "price": "Rp 200.000",
      "image": "assets/images/buket_coklat (4).jpg",
      "stock": "Tersedia: 10 pcs",
      "description": "Bouquet berisi coklat manis dengan hiasan cantik, cocok untuk hadiah Valentine atau ulang tahun."
    },
    {
      "name": "Buket Coklat Mix",
      "price": "Rp 115.000",
      "image": "assets/images/buket_coklat (5).jpg",
      "stock": "Tersedia: 6 pcs",
      "description": "Bouquet berisi coklat manis dengan hiasan cantik, cocok untuk hadiah Valentine atau ulang tahun."
    },
    {
      "name": "Buket Dried Flowers Mix All Flowers",
      "price": "Rp 80.000",
      "image": "assets/images/buket_dried (1).jpg",
      "stock": "Tersedia: 12 pcs",
      "description": "Bouquet bunga kering elegan dan tahan lama, sempurna untuk dekorasi rumah atau hadiah klasik."
    },
    {
      "name": "Buket Dried Flowers Coklat",
      "price": "Rp 155.000",
      "image": "assets/images/buket_dried (2).jpg",
      "stock": "Tersedia: 11 pcs",
      "description": "Bouquet bunga kering elegan dan tahan lama, sempurna untuk dekorasi rumah atau hadiah klasik."
    },
    {
      "name": "Buket Dried Flowers Full Pink",
      "price": "Rp 250.000",
      "image": "assets/images/buket_dried (3).jpg",
      "stock": "Tersedia: 9 pcs",
      "description": "Bouquet bunga kering elegan dan tahan lama, sempurna untuk dekorasi rumah atau hadiah klasik."
    },
    {
      "name": "Buket Dried Flowers Mix Mawar",
      "price": "Rp 185.000",
      "image": "assets/images/buket_dried (4).jpg",
      "stock": "Tersedia: 10 pcs",
      "description": "Bouquet bunga kering elegan dan tahan lama, sempurna untuk dekorasi rumah atau hadiah klasik."
    },
    {
      "name": "Buket Graduation 1",
      "price": "Rp 70.000",
      "image": "assets/images/buket_graduation (1).jpg",
      "stock": "Tersedia: 6 pcs",
      "description": "Bouquet spesial untuk momen wisuda, kombinasi bunga cerah dan dekorasi ucapan selamat."
    },
    {
      "name": "Buket Graduation 2",
      "price": "Rp 70.000",
      "image": "assets/images/buket_graduation (2).jpg",
      "stock": "Tersedia: 7 pcs",
      "description": "Bouquet spesial untuk momen wisuda, kombinasi bunga cerah dan dekorasi ucapan selamat."
    },
    {
      "name": "Buket Graduation 3",
      "price": "Rp 110.000",
      "image": "assets/images/buket_graduation (3).jpg",
      "stock": "Tersedia: 5 pcs",
      "description": "Bouquet spesial untuk momen wisuda, kombinasi bunga cerah dan dekorasi ucapan selamat."
    },
    {
      "name": "Buket Graduation 4",
      "price": "Rp 120.000",
      "image": "assets/images/buket_graduation (4).jpg",
      "stock": "Tersedia: 8 pcs",
      "description": "Bouquet spesial untuk momen wisuda, kombinasi bunga cerah dan dekorasi ucapan selamat."
    },
    {
      "name": "Buket Graduation 5",
      "price": "Rp 90.000",
      "image": "assets/images/buket_graduation (5).jpg",
      "stock": "Tersedia: 6 pcs",
      "description": "Bouquet spesial untuk momen wisuda, kombinasi bunga cerah dan dekorasi ucapan selamat."
    },
    {
      "name": "Buket Graduation 6",
      "price": "Rp 140.000",
      "image": "assets/images/buket_graduation (6).jpg",
      "stock": "Tersedia: 5 pcs",
      "description": "Bouquet spesial untuk momen wisuda, kombinasi bunga cerah dan dekorasi ucapan selamat."
    },
    {
      "name": "Buket Graduation 7",
      "price": "Rp 180.000",
      "image": "assets/images/buket_graduation (7).jpg",
      "stock": "Tersedia: 9 pcs",
      "description": "Bouquet spesial untuk momen wisuda, kombinasi bunga cerah dan dekorasi ucapan selamat."
    },
    {
      "name": "Buket Graduation 8",
      "price": "Rp 260.000",
      "image": "assets/images/buket_graduation (8).jpg",
      "stock": "Tersedia: 7 pcs",
      "description": "Bouquet spesial untuk momen wisuda, kombinasi bunga cerah dan dekorasi ucapan selamat."
    },
    {
      "name": "Bouquet Graduation 9",
      "price": "Rp 200.000",
      "image": "assets/images/buket_graduation (9).jpg",
      "stock": "Tersedia: 6 pcs",
      "description": "Bouquet spesial untuk momen wisuda, kombinasi bunga cerah dan dekorasi ucapan selamat."
    },
    {
      "name": "Buket Money 1 (Small)",
      "price": "Rp 350.000",
      "image": "assets/images/buket_money (1).jpg",
      "stock": "Tersedia: 5 pcs",
      "description": "Harga buket sudah termasuk dengan uang."
    },
    {
      "name": "Buket Money 2 (Large)",
      "price": "Rp 200.000",
      "image": "assets/images/buket_money (2).jpg",
      "stock": "Tersedia: 6 pcs",
      "description": "Harga buket sudah termasuk dengan uang."
    },
    {
      "name": "Buket Money 3 (Medium)",
      "price": "Rp 105.000",
      "image": "assets/images/buket_money (3).jpg",
      "stock": "Tersedia: 7 pcs",
      "description": "Harga buket sudah termasuk dengan uang."
    },
    {
      "name": "Buket Money 4 (Super Large)",
      "price": "Rp 1.130.000",
      "image": "assets/images/buket_money (4).jpg",
      "stock": "Tersedia: 6 pcs",
      "description": "Harga buket sudah termasuk dengan uang."
    },
    {
      "name": "Buket Money 5 (Large)",
      "price": "Rp 1.100.000",
      "image": "assets/images/buket_money (5).jpg",
      "stock": "Tersedia: 8 pcs",
      "description": "Harga buket sudah termasuk dengan uang."
    },
    {
      "name": "Buket Money 6 (Large)",
      "price": "Rp 1.160.000",
      "image": "assets/images/buket_money (6).jpg",
      "stock": "Tersedia: 9 pcs",
      "description": "Harga buket sudah termasuk dengan uang."
    },
    {
      "name": "Buket Money 7 (Large)",
      "price": "Rp 1.130.000",
      "image": "assets/images/buket_money (7).jpg",
      "stock": "Tersedia: 5 pcs",
      "description": "Harga buket sudah termasuk dengan uang."
    },
    {
      "name": "Buket Money 8 (Large)",
      "price": "Rp 1.500.000",
      "image": "assets/images/buket_money (8).jpg",
      "stock": "Tersedia: 7 pcs",
      "description": "Harga buket sudah termasuk dengan uang."
    },
    {
      "name": "Buket Money 9 (Super Large)",
      "price": "Rp 800.000",
      "image": "assets/images/buket_money (9).jpg",
      "stock": "Tersedia: 6 pcs",
      "description": "Harga buket sudah termasuk dengan uang."
    },
    {
      "name": "Buket Money 10 (Large)",
      "price": "Rp 3.320.000",
      "image": "assets/images/buket_money (10).jpg",
      "stock": "Tersedia: 8 pcs",
      "description": "Harga buket sudah termasuk dengan uang."
    },
    {
      "name": "Buket Money 11 (Super Large)",
      "price": "Rp 2.200.000",
      "image": "assets/images//buket_money (11).jpg",
      "stock": "Tersedia: 9 pcs",
      "description": "Harga buket sudah termasuk dengan uang."
    },
    {
      "name": "Buket Money 12 (Super Large)",
      "price": "Rp 1.190.000",
      "image": "assets/images/buket_money (12).jpg",
      "stock": "Tersedia: 6 pcs",
      "description": "Harga buket sudah termasuk dengan uang."
    },
    {
      "name": "Buket Fresh Flowers 1 Mawar (Small)",
      "price": "Rp 15.000",
      "image": "assets/images/fresh_flowers (1).jpg",
      "stock": "Tersedia: 8 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers Mawar + Aster (Small)",
      "price": "Rp 20.000",
      "image": "assets/images/fresh_flowers (2).jpg",
      "stock": "Tersedia: 7 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers Mawar + Aster (Medium)",
      "price": "Rp 40.000",
      "image": "assets/images/fresh_flowers (3).jpg",
      "stock": "Tersedia: 9 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers Gerbera + Krisan (Medium)",
      "price": "Rp 55.000",
      "image": "assets/images/fresh_flowers (4).jpg",
      "stock": "Tersedia: 6 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers Krisan (Medium)",
      "price": "Rp 60.000",
      "image": "assets/images/fresh_flowers (5).jpg",
      "stock": "Tersedia: 10 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers Mix (Medium)",
      "price": "Rp 90.000",
      "image": "assets/images/fresh_flowers (6).jpg",
      "stock": "Tersedia: 8 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers Mawar + Aster (Large)",
      "price": "Rp 90.000",
      "image": "assets/images/fresh_flowers (7).jpg",
      "stock": "Tersedia: 7 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers MIix (Large)",
      "price": "Rp 110.000",
      "image": "assets/images/fresh_flowers (8).jpg",
      "stock": "Tersedia: 9 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers Gerbera Putih (Medium)",
      "price": "Rp 115.000",
      "image": "assets/images/fresh_flowers (9).jpg",
      "stock": "Tersedia: 6 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers Gerbera + Mawar (Medium)",
      "price": "Rp 150.000",
      "image": "assets/images/fresh_flowers (10).jpg",
      "stock": "Tersedia: 8 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers Gerbera Pink (Small)",
      "price": "Rp 55.000",
      "image": "assets/images/fresh_flowers (11).jpg",
      "stock": "Tersedia: 7 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers Mawar Pink (Large)",
      "price": "Rp 190.000",
      "image": "assets/images/fresh_flowers (12).jpg",
      "stock": "Tersedia: 9 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Bouquet Fresh Flowers Lily Pink + Mawar (Large)",
      "price": "Rp 200.000",
      "image": "assets/images/fresh_flowers (13).jpg",
      "stock": "Tersedia: 6 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers Mawar Putih + Pink (Large)",
      "price": "Rp 300.000",
      "image": "assets/images/fresh_flowers (16).jpg",
      "stock": "Tersedia: 7 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers Lily Putih + Mawar (Large)",
      "price": "Rp 320.000",
      "image": "assets/images/fresh_flowers (17).jpg",
      "stock": "Tersedia: 6 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers Mawar Putih (Large)",
      "price": "Rp 235.000",
      "image": "assets/images/fresh_flowers (18).jpg",
      "stock": "Tersedia: 9 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers Mawar Putih + Merah (Super Large)",
      "price": "Rp 400.000",
      "image": "assets/images/fresh_flowers (19).jpg",
      "stock": "Tersedia: 8 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    },
    {
      "name": "Buket Fresh Flowers Mix Special (Large)",
      "price": "Rp 250.000",
      "image": "assets/images/fresh_flowers (20).jpg",
      "stock": "Tersedia: 7 pcs",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna, cocok untuk ucapan selamat atau hadiah romantis."
    }
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
        content: Text("${favoriteProduct.name} berhasil ditambahkan ke favorite ❤️"),
        backgroundColor: Colors.pink[300],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bouquet',
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