import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/user.dart';

class TentangKamiPage extends StatelessWidget {
  final User currentUser;

  const TentangKamiPage({super.key, required this.currentUser});

  // Contact Info
  static const String address =
      'Dusun Sambirejo 2, Desa Tepas, RT/RW 01/02, Kec. Geneng, Kab. Ngawi, Jawa Timur';
  static const String phone = '085738806544';
  static const String email = 'beflorist.official@gmail.com';
  static const String instagram = 'berlianakrd';
  static const String foundedYear = '2025';

  void _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Inquiry from Beflorist App',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchInstagram() async {
    final Uri instagramUri = Uri.parse('https://instagram.com/$instagram');
    if (await canLaunchUrl(instagramUri)) {
      await launchUrl(instagramUri, mode: LaunchMode.externalApplication);
    }
  }

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label berhasil disalin!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text(
          'Tentang Kami',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(),
            _buildStorySection(),
            _buildVisiMisiSection(),
            _buildWhyChooseUsSection(),
            _buildProductsSection(),
            _buildStatsSection(),
            _buildContactSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink[200]!, Colors.pink[50]!],
        ),
      ),
      child: Column(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset(
              'assets/images/beflorist_logo.png',
              height: 80,
              width: 80,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '🌸 BEFLORIST 🌸',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your Trusted Florist Partner',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Sejak $foundedYear',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorySection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_stories, color: Colors.pink[400], size: 28),
              const SizedBox(width: 8),
              const Text(
                'KISAH KAMI',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Beflorist didirikan pada tahun $foundedYear dengan visi untuk memberikan layanan florist terbaik bagi masyarakat Ngawi dan sekitarnya. Kami memahami bahwa setiap bunga memiliki makna dan cerita tersendiri, oleh karena itu kami berkomitmen untuk menyediakan bunga segar berkualitas tinggi yang dapat menyampaikan perasaan Anda dengan sempurna.',
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 12),
          const Text(
            'Dari buket pernikahan yang elegan hingga hampers spesial untuk momen istimewa, kami hadir untuk membantu Anda menciptakan kenangan indah yang tak terlupakan.',
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildVisiMisiSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Colors.pink[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flag, color: Colors.pink[400], size: 28),
              const SizedBox(width: 8),
              const Text(
                'VISI & MISI',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🎯 VISI',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Menjadi toko florist terpercaya dan terbaik di Ngawi yang memberikan produk berkualitas tinggi dan pelayanan memuaskan untuk setiap momen spesial pelanggan.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
                const SizedBox(height: 16),
                const Text(
                  '💼 MISI',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                const SizedBox(height: 8),
                _buildMissionItem(
                    '• Menyediakan bunga segar dan produk florist berkualitas premium'),
                _buildMissionItem(
                    '• Memberikan pelayanan ramah, cepat, dan profesional'),
                _buildMissionItem(
                    '• Menawarkan harga yang kompetitif dan terjangkau'),
                _buildMissionItem(
                    '• Terus berinovasi dalam desain dan produk'),
                _buildMissionItem(
                    '• Membangun kepercayaan jangka panjang dengan pelanggan'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, height: 1.5),
      ),
    );
  }

  Widget _buildWhyChooseUsSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.workspace_premium, color: Colors.pink[400], size: 28),
              const SizedBox(width: 8),
              const Text(
                'MENGAPA MEMILIH KAMI?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFeatureCard(
            Icons.local_florist,
            'Bunga Segar & Berkualitas',
            'Kami hanya menggunakan bunga segar pilihan terbaik untuk setiap pesanan',
          ),
          _buildFeatureCard(
            Icons.local_shipping,
            'Pengiriman Cepat & Aman',
            'Sistem pengiriman yang terpercaya memastikan bunga tiba dengan sempurna',
          ),
          _buildFeatureCard(
            Icons.attach_money,
            'Harga Terjangkau',
            'Harga kompetitif tanpa mengurangi kualitas produk dan pelayanan',
          ),
          _buildFeatureCard(
            Icons.design_services,
            'Custom Design Available',
            'Kami menerima custom design sesuai dengan keinginan Anda',
          ),
          _buildFeatureCard(
            Icons.support_agent,
            'Pelayanan Responsif',
            'Tim customer service kami siap membantu Anda kapan saja',
          ),
          _buildFeatureCard(
            Icons.verified,
            'Terpercaya & Berpengalaman',
            'Dipercaya oleh ribuan pelanggan untuk setiap momen spesial mereka',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.pink[100]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.pink, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Colors.pink[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.category, color: Colors.pink[400], size: 28),
              const SizedBox(width: 8),
              const Text(
                'PRODUK KAMI',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildProductChip('💐 Bouquet'),
              _buildProductChip('🌹 Fresh Flowers'),
              _buildProductChip('🎁 Gift Box'),
              _buildProductChip('🎀 Hampers'),
              _buildProductChip('📋 Papan Bunga'),
              _buildProductChip('🌸 Artificial Flowers'),
              _buildProductChip('💰 Money Bouquet'),
              _buildProductChip('🎓 Graduation Bouquet'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.pink[200]!),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: Colors.pink[400], size: 28),
              const SizedBox(width: 8),
              const Text(
                'PENCAPAIAN KAMI',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildStatCard('10.000+', 'Pelanggan', Icons.people)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('5.000+', 'Pesanan', Icons.shopping_bag)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildStatCard('4.8', 'Rating', Icons.star)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('100%', 'Kepuasan', Icons.sentiment_satisfied_alt)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink[300]!, Colors.pink[100]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Colors.pink[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.contact_phone, color: Colors.pink[400], size: 28),
              const SizedBox(width: 8),
              const Text(
                'HUBUNGI KAMI',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildContactCard(
            context,
            Icons.location_on,
            'Alamat',
            address,
            () => _copyToClipboard(context, address, 'Alamat'),
          ),
          _buildContactCard(
            context,
            Icons.phone,
            'Telepon',
            phone,
            _launchPhone,
            onLongPress: () => _copyToClipboard(context, phone, 'Nomor telepon'),
          ),
          _buildContactCard(
            context,
            Icons.email,
            'Email',
            email,
            _launchEmail,
            onLongPress: () => _copyToClipboard(context, email, 'Email'),
          ),
          _buildContactCard(
            context,
            Icons.camera_alt,
            'Instagram',
            '@$instagram',
            _launchInstagram,
            onLongPress: () => _copyToClipboard(context, instagram, 'Instagram'),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, color: Colors.pink[400]),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jam Operasional',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Senin - Minggu: 08:00 - 21:00 WIB',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    VoidCallback onTap, {
    VoidCallback? onLongPress,
  }) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.pink, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.pink[300]),
          ],
        ),
      ),
    );
  }
}