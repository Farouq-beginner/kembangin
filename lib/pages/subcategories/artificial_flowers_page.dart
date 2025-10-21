import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../models/product.dart';
import '../../services/cart_service.dart';
import '../../services/favorite_service.dart';
import '../../pages/cart_page.dart';
import '../../pages/favorite_page.dart'; 

class ArtificialFlowersPage extends StatefulWidget {
  final User currentUser;

  const ArtificialFlowersPage({super.key, required this.currentUser});

  @override
  State<ArtificialFlowersPage> createState() => _ArtificialFlowersPageState();
}

class _ArtificialFlowersPageState extends State<ArtificialFlowersPage> {
  final List<Map<String, String>> products = [
    {
      "name": "Mawar Merah",
      "price": "Rp 20.000 / ikat",
      "image": "assets/images/mawar_merah.png",
      "stock": "Tersedia: 20 ikat",
      "description":
          "Mawar merah segar dengan aroma khas, simbol cinta dan kasih sayang yang mendalam."
    },
    {
      "name": "Mawar Putih",
      "price": "Rp 22.000 / ikat",
      "image": "assets/images/mawar_putih.png",
      "stock": "Tersedia: 15 ikat",
      "description":
          "Mawar putih segar melambangkan kesucian dan ketulusan hati."
    },
    {
      "name": "Mawar Pink",
      "price": "Rp 22.000 / ikat",
      "image": "assets/images/mawar_pink.png",
      "stock": "Tersedia: 15 ikat",
      "description":
          "Mawar pink segar dengan warna lembut, simbol kasih sayang dan kehangatan."
    },
    {
      "name": "Mawar Biru",
      "price": "Rp 25.000 / ikat",
      "image": "assets/images/mawar_biru.png",
      "stock": "Tersedia: 10 ikat",
      "description":
          "Mawar biru langka dan eksotis, melambangkan keajaiban dan keunikan cinta."
    },
    {
      "name": "Lily Putih",
      "price": "Rp 30.000 / ikat",
      "image": "assets/images/lily_putih.png",
      "stock": "Tersedia: 12 ikat",
      "description":
          "Lily putih elegan dengan aroma lembut, cocok untuk dekorasi atau acara resmi."
    },
    {
      "name": "Lily Pink",
      "price": "Rp 32.000 / ikat",
      "image": "assets/images/lily_pink.png",
      "stock": "Tersedia: 10 ikat",
      "description":
          "Lily pink segar yang menambah kesan manis dan lembut pada setiap momen."
    },
    {
      "name": "Tulip Merah",
      "price": "Rp 28.000 / ikat",
      "image": "assets/images/tulip_merah.png",
      "stock": "Tersedia: 18 ikat",
      "description": "Tulip merah segar, simbol cinta sejati dan kehangatan."
    },
    {
      "name": "Tulip Putih",
      "price": "Rp 28.000 / ikat",
      "image": "assets/images/tulip_putih.png",
      "stock": "Tersedia: 18 ikat",
      "description":
          "Tulip putih segar melambangkan ketulusan dan kesederhanaan."
    },
    {
      "name": "Tulip Pink",
      "price": "Rp 28.000 / ikat",
      "image": "assets/images/tulip_pink.png",
      "stock": "Tersedia: 20 ikat",
      "description":
          "Tulip pink segar yang lembut dan manis, cocok untuk hadiah spesial."
    },
    {
      "name": "Krisan Putih",
      "price": "Rp 12.000 / ikat",
      "image": "assets/images/krisan_putih.png",
      "stock": "Tersedia: 25 ikat",
      "description":
          "Krisan putih segar, simbol ketulusan dan kesederhanaan alami."
    },
    {
      "name": "Krisan Kuning",
      "price": "Rp 12.000 / ikat",
      "image": "assets/images/krisan_kuning.png",
      "stock": "Tersedia: 25 ikat",
      "description":
          "Krisan kuning ceria, memberi warna dan kebahagiaan di setiap ruangan."
    },
    {
      "name": "Krisan Pink",
      "price": "Rp 12.000 / ikat",
      "image": "assets/images/krisan_pink.png",
      "stock": "Tersedia: 20 ikat",
      "description":
          "Krisan pink lembut, melambangkan kasih sayang dan kelembutan hati."
    },
    {
      "name": "Gerbera Merah",
      "price": "Rp 15.000 / ikat",
      "image": "assets/images/gerbera_merah.png",
      "stock": "Tersedia: 30 ikat",
      "description":
          "Gerbera merah segar yang cerah, simbol semangat dan kebahagiaan."
    },
    {
      "name": "Gerbera Pink",
      "price": "Rp 15.000 / ikat",
      "image": "assets/images/gerbera_pink.png",
      "stock": "Tersedia: 25 ikat",
      "description":
          "Gerbera pink segar, menambah keindahan dan kesan lembut di ruangan."
    },
    {
      "name": "Gerbera Kuning",
      "price": "Rp 15.000 / ikat",
      "image": "assets/images/gerbera_kuning.png",
      "stock": "Tersedia: 28 ikat",
      "description":
          "Gerbera kuning segar ceria, melambangkan persahabatan dan sukacita."
    },
    {
      "name": "Gerbera Orange",
      "price": "Rp 15.000 / ikat",
      "image": "assets/images/gerbera_orange.png",
      "stock": "Tersedia: 25 ikat",
      "description":
          "Gerbera orange segar dengan warna hangat yang menyemangati hari."
    },
    {
      "name": "Baby Breath",
      "price": "Rp 50.000 / ikat",
      "image": "assets/images/baby_breath.png",
      "stock": "Tersedia: 10 ikat",
      "description":
          "Baby Breath segar, bunga kecil putih lembut yang cocok sebagai pelengkap buket."
    },
    {
      "name": "Anggrek Putih",
      "price": "Rp 65.000 / ikat",
      "image": "assets/images/anggrek_putih.png",
      "stock": "Tersedia: 10 ikat",
      "description":
          "Anggrek putih segar dan elegan, melambangkan kemurnian dan keanggunan."
    },
    {
      "name": "Anggrek Merah",
      "price": "Rp 70.000 / ikat",
      "image": "assets/images/anggrek_merah.png",
      "stock": "Tersedia: 8 ikat",
      "description": "Anggrek merah eksotis, simbol cinta yang kuat dan berani."
    },
    {
      "name": "Anggrek Ungu",
      "price": "Rp 75.000 / ikat",
      "image": "assets/images/anggrek_ungu.png",
      "stock": "Tersedia: 6 ikat",
      "description":
          "Anggrek ungu segar, melambangkan kemewahan, kehormatan, dan pesona alami."
    },
  ];

  void _addToCart(Map<String, String> product) {
    final price =
        int.tryParse(product['price']!.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final stock =
        int.tryParse(product['stock']!.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

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
          'Artificial Flowers',
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