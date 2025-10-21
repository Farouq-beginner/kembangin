import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/beflorist_drawer.dart';
import '../widgets/notification_icon.dart';
import '../models/user.dart';
import 'produk_page.dart';
import 'home_sections/diskon_page.dart';
import 'home_sections/tentang_kami_page.dart';
import 'home_sections/best_seller_page.dart';
import 'home_sections/review_page.dart';

class HomePage extends StatelessWidget {
  final User currentUser;

  const HomePage({super.key, required this.currentUser});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Tidak bisa membuka $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BefloristDrawer(
        selectedIndex: 0,
        onItemSelected: (i) {},
        currentUser: currentUser,
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 182, 193, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Beflorist Home",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [NotificationIcon()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= Hero Section =================
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/dashboard_bg.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  color: Colors.pink.withOpacity(0.3),
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Halo, ${currentUser.username} 👋",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Welcome to Beflorist",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ================= Quote Section =================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "✨ Your Bloom, Your Story ✨",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 105, 180, 1),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Kami menghadirkan cara baru untuk berbelanja bunga dan hadiah. "
                "Menggabungkan kualitas, kreativitas, dan pelayanan terbaik, "
                "Beflorist menjadi pilihan tepat untuk momen spesial Anda.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54, height: 1.5),
              ),
            ),

            const SizedBox(height: 30),

            // ================= Social Media =================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.instagram, color: Colors.pink, size: 30),
                  onPressed: () => _launchUrl("https://www.instagram.com/berlianakrd"),
                ),
                const SizedBox(width: 15),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 30),
                  onPressed: () => _launchUrl("https://wa.me/6285738806544"),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ================= Feature Cards =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Promo & Diskon
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.local_offer, color: Colors.pink),
                      title: const Text(
                        "Promo & Diskon",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text("Dapatkan penawaran spesial setiap minggu ✨"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => DiskonPage(currentUser: currentUser)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Best Seller
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.star, color: Colors.amber),
                      title: const Text(
                        "Best Seller",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text("Produk favorit pelanggan sepanjang tahun 🌟"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => BestSellerPage(currentUser: currentUser)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Review
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.chat, color: Colors.green),
                      title: const Text(
                        "Review Pelanggan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text("Lihat pengalaman nyata dari pelanggan 💬"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ReviewPage(currentUser: currentUser)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Lihat Semua Produk
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.shopping_bag, color: Colors.purple),
                      title: const Text(
                        "Lihat Semua Produk",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text("Jelajahi semua kategori bunga & hadiah 🎁"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ProdukPage(currentUser: currentUser)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Tentang Kami (di bagian bawah sendiri)
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.info, color: Colors.blue),
                      title: const Text(
                        "Tentang Kami",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text("Kenali lebih dekat tentang toko Beflorist 🌸"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => TentangKamiPage(currentUser: currentUser)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ================= Footer =================
            Container(
              padding: const EdgeInsets.all(15),
              color: Colors.pink.shade50,
              width: double.infinity,
              child: Column(
                children: const [
                  Text(
                    "© 2025 Beflorist. All rights reserved.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "by : berliana kurnia dewi",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
