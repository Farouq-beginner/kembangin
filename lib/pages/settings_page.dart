import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/beflorist_drawer.dart';
import '../models/user.dart';
import 'login_page.dart';

class SettingPage extends StatefulWidget {
  final User currentUser;

  const SettingPage({super.key, required this.currentUser});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _notificationPromo = true;
  bool _notificationOrder = true;
  bool _notificationNewsletter = false;
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationPromo = prefs.getBool('notif_promo') ?? true;
      _notificationOrder = prefs.getBool('notif_order') ?? true;
      _notificationNewsletter = prefs.getBool('notif_newsletter') ?? false;
      _darkMode = prefs.getBool('dark_mode') ?? false;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_promo', _notificationPromo);
    await prefs.setBool('notif_order', _notificationOrder);
    await prefs.setBool('notif_newsletter', _notificationNewsletter);
    await prefs.setBool('dark_mode', _darkMode);
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: widget.currentUser.username);
    final emailController = TextEditingController(text: widget.currentUser.email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
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

                // Update current user
                setState(() {
                  widget.currentUser.username = nameController.text;
                  widget.currentUser.email = emailController.text;
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile berhasil diupdate!'),
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
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Clear saved session (optional)
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('isLoggedIn');

                // Navigate to login page
                if (mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BefloristDrawer(
        selectedIndex: 4, // Index 4 untuk Settings
        currentUser: widget.currentUser,
        onItemSelected: (_) {},
      ),
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text(
          'Pengaturan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, // Hilangkan tombol back default
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu), // Garis tiga drawer
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),
            const Divider(height: 1),
            _buildAccountSection(),
            const Divider(height: 1),
            _buildPreferencesSection(),
            const Divider(height: 1),
            _buildOrderSection(),
            const Divider(height: 1),
            _buildSupportSection(),
            const Divider(height: 1),
            _buildLogoutButton(),
            const SizedBox(height: 24),
            _buildVersionInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink[100]!, Colors.pink[50]!],
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.pink[200],
            child: const Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            widget.currentUser.username,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.currentUser.email,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _showEditProfileDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[300],
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            icon: const Icon(Icons.edit),
            label: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.account_circle, color: Colors.pink[400]),
              const SizedBox(width: 8),
              const Text(
                'AKUN',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        _buildMenuItem(
          Icons.person,
          'Edit Profile',
          'Ubah nama dan email',
          _showEditProfileDialog,
        ),
        _buildMenuItem(
          Icons.lock,
          'Ubah Password',
          'Ganti password akun',
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur dalam pengembangan')),
            );
          },
        ),
        _buildMenuItem(
          Icons.location_on,
          'Alamat Pengiriman',
          'Kelola alamat tersimpan',
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur dalam pengembangan')),
            );
          },
        ),
        _buildMenuItem(
          Icons.payment,
          'Metode Pembayaran',
          'Kelola metode pembayaran',
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur dalam pengembangan')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPreferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.settings, color: Colors.pink[400]),
              const SizedBox(width: 8),
              const Text(
                'PREFERENSI',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        _buildSwitchItem(
          Icons.notifications,
          'Notifikasi Promo',
          'Terima notifikasi promo dan diskon',
          _notificationPromo,
          (value) {
            setState(() {
              _notificationPromo = value;
            });
            _saveSettings();
          },
        ),
        _buildSwitchItem(
          Icons.shopping_bag,
          'Notifikasi Pesanan',
          'Update status pesanan',
          _notificationOrder,
          (value) {
            setState(() {
              _notificationOrder = value;
            });
            _saveSettings();
          },
        ),
        _buildSwitchItem(
          Icons.email,
          'Newsletter',
          'Terima newsletter via email',
          _notificationNewsletter,
          (value) {
            setState(() {
              _notificationNewsletter = value;
            });
            _saveSettings();
          },
        ),
        _buildSwitchItem(
          Icons.dark_mode,
          'Dark Mode',
          'Tema gelap (dalam pengembangan)',
          _darkMode,
          (value) {
            setState(() {
              _darkMode = value;
            });
            _saveSettings();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Dark mode dalam pengembangan')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildOrderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.shopping_cart, color: Colors.pink[400]),
              const SizedBox(width: 8),
              const Text(
                'PESANAN',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        _buildMenuItem(
          Icons.history,
          'Riwayat Pesanan',
          'Lihat semua pesanan',
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur dalam pengembangan')),
            );
          },
        ),
        _buildMenuItem(
          Icons.location_on,
          'Alamat Tersimpan',
          'Kelola alamat pengiriman',
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur dalam pengembangan')),
            );
          },
        ),
        _buildMenuItem(
          Icons.local_offer,
          'Voucher Saya',
          'Lihat voucher yang dimiliki',
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur dalam pengembangan')),
            );
          },
        ),
        _buildMenuItem(
          Icons.favorite,
          'Favorite',
          'Produk favorit saya',
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur dalam pengembangan')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.help, color: Colors.pink[400]),
              const SizedBox(width: 8),
              const Text(
                'BANTUAN & INFO',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        _buildMenuItem(
          Icons.help_center,
          'Pusat Bantuan',
          'FAQ dan panduan',
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur dalam pengembangan')),
            );
          },
        ),
        _buildMenuItem(
          Icons.support_agent,
          'Hubungi Customer Service',
          'Chat dengan CS kami',
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur dalam pengembangan')),
            );
          },
        ),
        _buildMenuItem(
          Icons.description,
          'Syarat & Ketentuan',
          'Baca syarat dan ketentuan',
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur dalam pengembangan')),
            );
          },
        ),
        _buildMenuItem(
          Icons.privacy_tip,
          'Kebijakan Privasi',
          'Kebijakan privasi aplikasi',
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur dalam pengembangan')),
            );
          },
        ),
        _buildMenuItem(
          Icons.info,
          'Tentang Beflorist',
          'Info tentang aplikasi',
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur dalam pengembangan')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.pink[300]),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem(
    IconData icon,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.pink[300]),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.pink[300],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _showLogoutDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.logout),
          label: const Text(
            'Keluar dari Akun',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Center(
      child: Column(
        children: [
          Text(
            'Beflorist',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Versi 1.0.0',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}