import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/beflorist_drawer.dart';
import '../../models/user.dart';

class HelpPage extends StatefulWidget {
  final User currentUser;

  const HelpPage({super.key, required this.currentUser});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  int? _expandedCategoryIndex;
  int? _expandedFaqIndex;

  final List<Map<String, dynamic>> faqCategories = [
    {
      'title': '🛒 Cara Pemesanan',
      'icon': Icons.shopping_cart,
      'faqs': [
        {
          'question': 'Bagaimana cara memesan produk?',
          'answer':
              'Anda dapat memesan produk dengan cara:\n1. Pilih produk yang diinginkan\n2. Klik tombol "Tambah ke Keranjang"\n3. Buka keranjang dan klik "Checkout"\n4. Lengkapi data pengiriman dan pilih metode pembayaran\n5. Konfirmasi pesanan Anda'
        },
        {
          'question': 'Apakah bisa pesan custom bouquet?',
          'answer':
              'Ya, kami menerima pesanan custom bouquet! Hubungi customer service kami melalui WhatsApp untuk konsultasi desain dan harga.'
        },
        {
          'question': 'Berapa minimal pemesanan?',
          'answer':
              'Tidak ada minimal pemesanan. Anda bisa memesan mulai dari 1 produk saja.'
        },
        {
          'question': 'Apakah harus registrasi terlebih dahulu?',
          'answer':
              'Ya, Anda perlu membuat akun terlebih dahulu untuk dapat melakukan pemesanan dan tracking.'
        },
      ],
    },
    {
      'title': '💳 Pembayaran',
      'icon': Icons.payment,
      'faqs': [
        {
          'question': 'Metode pembayaran apa saja yang tersedia?',
          'answer':
              'Kami menerima pembayaran melalui:\n• Transfer Bank (BCA, Mandiri, BRI, BNI)\n• E-Wallet (GoPay, OVO, DANA, ShopeePay)\n• COD (Cash on Delivery) untuk area tertentu\n• Kartu Kredit/Debit'
        },
        {
          'question': 'Bagaimana cara konfirmasi pembayaran?',
          'answer':
              'Setelah melakukan pembayaran, kirimkan bukti transfer melalui:\n1. Upload di aplikasi (menu "Pesanan Saya")\n2. WhatsApp ke 085738806544\n3. Email ke beflorist.official@gmail.com'
        },
        {
          'question': 'Berapa lama konfirmasi pembayaran diproses?',
          'answer':
              'Konfirmasi pembayaran akan diproses maksimal 1 jam setelah bukti transfer diterima (pada jam operasional 08.00-21.00 WIB).'
        },
        {
          'question': 'Apakah ada biaya tambahan?',
          'answer':
              'Biaya yang tertera sudah termasuk harga produk. Biaya pengiriman akan dihitung saat checkout berdasarkan lokasi tujuan.'
        },
      ],
    },
    {
      'title': '🚚 Pengiriman',
      'icon': Icons.local_shipping,
      'faqs': [
        {
          'question': 'Berapa lama waktu pengiriman?',
          'answer':
              'Estimasi pengiriman:\n• Same day delivery: Pesanan sebelum 12:00 WIB\n• Ngawi & sekitarnya: 1-2 hari kerja\n• Luar kota: 2-3 hari kerja\n• Luar pulau: 3-5 hari kerja'
        },
        {
          'question': 'Apakah bisa kirim ke luar kota?',
          'answer':
              'Ya, kami melayani pengiriman ke seluruh Indonesia. Ongkir akan disesuaikan dengan jarak dan ekspedisi yang dipilih.'
        },
        {
          'question': 'Bagaimana cara tracking pesanan?',
          'answer':
              'Anda dapat tracking pesanan melalui:\n1. Menu "Pesanan Saya" di aplikasi\n2. Nomor resi yang dikirimkan via WhatsApp/Email\n3. Hubungi customer service untuk info terkini'
        },
        {
          'question': 'Apakah bisa request waktu pengiriman?',
          'answer':
              'Ya, Anda dapat request waktu pengiriman saat checkout. Kami akan berusaha memenuhi request sesuai ketersediaan kurir.'
        },
        {
          'question': 'Bagaimana jika alamat salah?',
          'answer':
              'Segera hubungi customer service jika ada kesalahan alamat. Perubahan alamat hanya dapat dilakukan sebelum pesanan dikirim.'
        },
      ],
    },
    {
      'title': '↩️ Pengembalian & Refund',
      'icon': Icons.keyboard_return,
      'faqs': [
        {
          'question': 'Apakah bisa retur/tukar produk?',
          'answer':
              'Kami menerima retur/tukar produk jika:\n• Produk rusak saat diterima\n• Produk tidak sesuai pesanan\n• Bunga layu/mati saat diterima\nHubungi CS maksimal 2 jam setelah produk diterima dengan foto bukti.'
        },
        {
          'question': 'Bagaimana proses refund?',
          'answer':
              'Proses refund:\n1. Ajukan komplain dengan bukti foto\n2. Tim akan verifikasi (1x24 jam)\n3. Jika disetujui, refund akan diproses\n4. Dana kembali 3-7 hari kerja\nRefund dapat berupa dana kembali atau voucher.'
        },
        {
          'question': 'Apakah bisa cancel pesanan?',
          'answer':
              'Pembatalan pesanan hanya dapat dilakukan jika pesanan belum diproses. Hubungi CS segera setelah melakukan pemesanan untuk pembatalan.'
        },
      ],
    },
    {
      'title': '🔒 Akun & Keamanan',
      'icon': Icons.security,
      'faqs': [
        {
          'question': 'Bagaimana cara reset password?',
          'answer':
              'Untuk reset password:\n1. Klik "Lupa Password" di halaman login\n2. Masukkan email terdaftar\n3. Cek email untuk link reset\n4. Buat password baru\nAtau hubungi CS jika mengalami kendala.'
        },
        {
          'question': 'Apakah data saya aman?',
          'answer':
              'Ya, semua data pribadi Anda tersimpan dengan aman dan terenkripsi. Kami tidak akan membagikan data Anda ke pihak ketiga tanpa izin.'
        },
        {
          'question': 'Bagaimana cara update data profil?',
          'answer':
              'Anda dapat update data profil melalui menu "Akun Saya" > "Edit Profil". Perubahan akan tersimpan secara otomatis.'
        },
      ],
    },
    {
      'title': '🌸 Produk',
      'icon': Icons.inventory,
      'faqs': [
        {
          'question': 'Apakah bunga dijamin segar?',
          'answer':
              'Ya, kami hanya menggunakan bunga segar pilihan terbaik. Setiap produk dicek kualitasnya sebelum dikirim. Garansi kesegaran hingga 3 hari dengan perawatan yang tepat.'
        },
        {
          'question': 'Bagaimana cara merawat bunga agar tahan lama?',
          'answer':
              'Tips merawat bunga:\n• Potong ujung tangkai secara diagonal\n• Ganti air setiap 2 hari\n• Letakkan di tempat sejuk, hindari sinar matahari langsung\n• Buang daun yang terendam air\n• Jauhkan dari buah-buahan'
        },
        {
          'question': 'Apakah ada katalog produk lengkap?',
          'answer':
              'Ya, Anda dapat melihat katalog lengkap kami di:\n• Aplikasi Beflorist\n• Instagram @berlianakrd\n• WhatsApp customer service'
        },
        {
          'question': 'Apakah stok selalu tersedia?',
          'answer':
              'Stok produk dapat berubah sewaktu-waktu. Untuk memastikan ketersediaan, silakan cek di aplikasi atau hubungi customer service.'
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> popularTopics = [
    {
      'icon': Icons.location_on,
      'title': 'Tracking Pesanan',
      'description': 'Cara melacak status pesanan Anda'
    },
    {
      'icon': Icons.cancel,
      'title': 'Batalkan Pesanan',
      'description': 'Cara membatalkan pesanan yang sudah dibuat'
    },
    {
      'icon': Icons.local_offer,
      'title': 'Voucher & Promo',
      'description': 'Info tentang voucher dan promo terkini'
    },
    {
      'icon': Icons.verified_user,
      'title': 'Garansi Produk',
      'description': 'Kebijakan garansi dan jaminan kualitas'
    },
  ];

  void _launchWhatsApp() async {
    final Uri whatsappUri = Uri.parse('https://wa.me/6285738806544');
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    }
  }

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'beflorist.official@gmail.com',
      query: 'subject=Bantuan Beflorist',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchInstagram() async {
    final Uri instagramUri = Uri.parse('https://instagram.com/berlianakrd');
    if (await canLaunchUrl(instagramUri)) {
      await launchUrl(instagramUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BefloristDrawer(
        selectedIndex: 6,
        currentUser: widget.currentUser,
        onItemSelected: (_) {},
      ),
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text(
          'Pusat Bantuan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(),
            _buildQuickActions(),
            _buildPopularTopics(),
            _buildFAQCategories(),
            _buildContactSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
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
          Icon(Icons.help_center, size: 64, color: Colors.pink[400]),
          const SizedBox(height: 16),
          const Text(
            'Ada yang bisa kami bantu?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Temukan jawaban atas pertanyaan Anda',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionCard(
              Icons.chat,
              'Chat WA',
              Colors.green,
              _launchWhatsApp,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildQuickActionCard(
              Icons.email,
              'Email',
              Colors.blue,
              _launchEmail,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildQuickActionCard(
              Icons.camera_alt,
              'Instagram',
              Colors.purple,
              _launchInstagram,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularTopics() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🔥 Topik Populer',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...popularTopics.map((topic) => _buildPopularTopicCard(topic)),
        ],
      ),
    );
  }

  Widget _buildPopularTopicCard(Map<String, dynamic> topic) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.pink[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(topic['icon'], color: Colors.pink[300]),
        ),
        title: Text(
          topic['title'],
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          topic['description'],
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Info ${topic['title']} segera hadir!')),
          );
        },
      ),
    );
  }

  Widget _buildFAQCategories() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '❓ Pertanyaan Umum',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(
            faqCategories.length,
            (categoryIndex) => _buildFAQCategory(categoryIndex),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQCategory(int categoryIndex) {
    final category = faqCategories[categoryIndex];
    final isExpanded = _expandedCategoryIndex == categoryIndex;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          ListTile(
            leading: Icon(category['icon'], color: Colors.pink[300]),
            title: Text(
              category['title'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
            ),
            onTap: () {
              setState(() {
                _expandedCategoryIndex =
                    isExpanded ? null : categoryIndex;
                _expandedFaqIndex = null;
              });
            },
          ),
          if (isExpanded)
            ...List.generate(
              (category['faqs'] as List).length,
              (faqIndex) => _buildFAQItem(categoryIndex, faqIndex),
            ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(int categoryIndex, int faqIndex) {
    final faq = faqCategories[categoryIndex]['faqs'][faqIndex];
    final isExpanded = _expandedCategoryIndex == categoryIndex &&
        _expandedFaqIndex == faqIndex;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: ExpansionTile(
        title: Text(
          faq['question'],
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          isExpanded ? Icons.remove : Icons.add,
          size: 20,
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            _expandedFaqIndex = expanded ? faqIndex : null;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              faq['answer'],
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink[100]!, Colors.pink[50]!],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💬 Masih Butuh Bantuan?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Hubungi customer service kami',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          _buildContactItem(Icons.phone, 'WhatsApp', '085738806544'),
          const SizedBox(height: 8),
          _buildContactItem(
              Icons.email, 'Email', 'beflorist.official@gmail.com'),
          const SizedBox(height: 8),
          _buildContactItem(Icons.camera_alt, 'Instagram', '@berlianakrd'),
          const SizedBox(height: 8),
          _buildContactItem(Icons.access_time, 'Jam Operasional',
              'Senin-Minggu: 08:00 - 21:00 WIB'),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.pink[700]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
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
}