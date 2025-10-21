import 'package:flutter/material.dart';
import '../widgets/beflorist_drawer.dart';
import '../../models/user.dart';
import '../../models/product.dart';
import '../../services/favorite_service.dart';

class FavoritePage extends StatefulWidget {
  final User currentUser;

  const FavoritePage({super.key, required this.currentUser});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  void _removeFromFavorite(Product product) {
    FavoriteService().remove(product);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product.name} dihapus dari favorite ❌"),
        backgroundColor: Colors.pink[300],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favorites = FavoriteService().favorites;

    return Scaffold(
      drawer: BefloristDrawer(
        selectedIndex: 3, 
        currentUser: widget.currentUser,
        onItemSelected: (_) {},
      ),
      appBar: AppBar(
        title: const Text("Favorite", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.pink[200],
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                "Belum ada produk di favorite ❤️",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        product.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Rp ${product.price}", style: const TextStyle(color: Colors.red)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.pink),
                      onPressed: () => _removeFromFavorite(product),
                    ),
                  ),
                );
              },
            ),
    );
  }
}