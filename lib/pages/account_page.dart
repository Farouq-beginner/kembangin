import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/beflorist_drawer.dart';
import '../../models/user.dart';

class AccountPage extends StatefulWidget {
  final User currentUser;

  const AccountPage({
    super.key,
    required this.currentUser,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username');
    final savedEmail = prefs.getString('email');

    if (savedUsername != null && savedEmail != null) {
      setState(() {
        widget.currentUser.username = savedUsername;
        widget.currentUser.email = savedEmail;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: BefloristDrawer(
        selectedIndex: 5, // Index 5 untuk Account
        currentUser: widget.currentUser,
        onItemSelected: (_) {},
      ),
      appBar: AppBar(
        title: const Text(
          'Akun Saya',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[200],
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Profile Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.pink[200],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                child: Column(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.pink[300],
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Nama User
                    Text(
                      widget.currentUser.username,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Email User
                    Text(
                      widget.currentUser.email,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Edit Profile Button
                    ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to edit profile
                        _showEditProfileDialog();
                      },
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text('Edit Profil'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.pink[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Menu Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  // Account Settings
                  _buildSectionTitle('Pengaturan Akun'),
                  _buildMenuItem(
                    icon: Icons.person_outline,
                    title: 'Informasi Pribadi',
                    subtitle: 'Ubah data pribadi Anda',
                    onTap: () {
                      _showEditProfileDialog();
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.location_on_outlined,
                    title: 'Alamat Pengiriman',
                    subtitle: 'Kelola alamat pengiriman',
                    onTap: () {
                      _showAddressDialog();
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.lock_outline,
                    title: 'Ubah Password',
                    subtitle: 'Perbarui kata sandi Anda',
                    onTap: () {
                      _showChangePasswordDialog();
                    },
                  ),

                  const SizedBox(height: 20),

                  // Orders & History
                  _buildSectionTitle('Pesanan & Riwayat'),
                  _buildMenuItem(
                    icon: Icons.shopping_bag_outlined,
                    title: 'Pesanan Saya',
                    subtitle: 'Lihat status pesanan Anda',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur Pesanan Saya segera hadir!'),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.history,
                    title: 'Riwayat Transaksi',
                    subtitle: 'Lihat riwayat pembelian',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur Riwayat Transaksi segera hadir!'),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.favorite_outline,
                    title: 'Wishlist',
                    subtitle: 'Produk favorit Anda',
                    onTap: () {
                      Navigator.pushNamed(context, '/favorite');
                    },
                  ),

                  const SizedBox(height: 20),

                  // Support
                  _buildSectionTitle('Bantuan & Dukungan'),
                  _buildMenuItem(
                    icon: Icons.help_outline,
                    title: 'Pusat Bantuan',
                    subtitle: 'FAQ dan panduan',
                    onTap: () {
                      _showHelpDialog();
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.phone_outlined,
                    title: 'Hubungi Kami',
                    subtitle: 'Customer service',
                    onTap: () {
                      _showContactDialog();
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.star_outline,
                    title: 'Beri Rating',
                    subtitle: 'Bantu kami berkembang',
                    onTap: () {
                      _showRatingDialog();
                    },
                  ),

                  const SizedBox(height: 20),

                  // Settings
                  _buildSectionTitle('Lainnya'),
                  _buildMenuItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notifikasi',
                    subtitle: 'Pengaturan pemberitahuan',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                      activeColor: Colors.pink[300],
                    ),
                    onTap: null,
                  ),
                  _buildMenuItem(
                    icon: Icons.language_outlined,
                    title: 'Bahasa',
                    subtitle: 'Indonesia',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur ganti bahasa segera hadir!'),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.info_outline,
                    title: 'Tentang Aplikasi',
                    subtitle: 'Versi 1.0.0',
                    onTap: () {
                      _showAboutDialog();
                    },
                  ),

                  const SizedBox(height: 30),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showLogoutConfirmation();
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text(
                        'Keluar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.pink[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.pink[300]),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: trailing ??
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        onTap: onTap,
      ),
    );
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(
      text: widget.currentUser.username,
    );
    final emailController = TextEditingController(
      text: widget.currentUser.email,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              controller: nameController,
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Save to SharedPreferences
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('username', nameController.text);
              await prefs.setString('email', emailController.text);

              // Update current user dan UI
              setState(() {
                widget.currentUser.username = nameController.text;
                widget.currentUser.email = emailController.text;
              });

              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profil berhasil diperbarui!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[300],
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showAddressDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alamat Pengiriman'),
        content: const Text(
          'Anda belum memiliki alamat pengiriman.\nTambahkan alamat untuk memudahkan proses pengiriman.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur tambah alamat segera hadir!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[300],
            ),
            child: const Text('Tambah Alamat'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ubah Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password Lama',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password Baru',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_open),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Konfirmasi Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password berhasil diubah!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[300],
            ),
            child: const Text('Ubah'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pusat Bantuan'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pertanyaan Umum:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Q: Bagaimana cara memesan?\nA: Pilih produk, tambahkan ke keranjang, lalu checkout.'),
              SizedBox(height: 10),
              Text('Q: Apakah bisa custom bouquet?\nA: Ya, hubungi customer service kami.'),
              SizedBox(height: 10),
              Text('Q: Berapa lama pengiriman?\nA: Pengiriman memakan waktu 1-3 hari kerja.'),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[300],
            ),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hubungi Kami'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactRow(Icons.phone, 'WhatsApp', '085738806544'),
            const SizedBox(height: 10),
            _buildContactRow(Icons.email, 'Email', 'beflorist.official@gmail.com'),
            const SizedBox(height: 10),
            _buildContactRow(Icons.camera_alt, 'Instagram', '@berlianakrd'),
            const SizedBox(height: 10),
            _buildContactRow(Icons.access_time, 'Jam Operasional', '08.00 - 21.00 WIB'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[300],
            ),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.pink[300], size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Beri Rating'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Bagaimana pengalaman Anda menggunakan Beflorist?'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Komentar (opsional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Terima kasih atas rating Anda! ⭐')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[300],
            ),
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tentang Beflorist'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Beflorist',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text('Versi 1.0.0'),
            SizedBox(height: 15),
            Text(
              'Beflorist adalah aplikasi toko bunga online yang menyediakan berbagai pilihan bunga segar, bouquet, hampers, dan gift box untuk berbagai momen spesial Anda.',
            ),
            SizedBox(height: 15),
            Text(
              '© 2025 Beflorist. All rights reserved.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[300],
            ),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Keluar'),
        content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Clear session
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('isLoggedIn');
              
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}