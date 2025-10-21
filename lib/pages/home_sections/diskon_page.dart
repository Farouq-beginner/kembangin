import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/user.dart';
import '../../models/product.dart';
import '../../services/cart_service.dart';
import '../../services/voucher_service.dart';

class DiskonPage extends StatefulWidget {
  final User currentUser;

  const DiskonPage({super.key, required this.currentUser});

  @override
  State<DiskonPage> createState() => _DiskonPageState();
}

class _DiskonPageState extends State<DiskonPage> {
  late Timer _timer;
  Duration _timeRemaining = const Duration(hours: 12);

  // Produk Flash Sale (pilihan manual)
  final List<Map<String, dynamic>> flashSaleProducts = [
    {
      "name": "Buket Artificial Mawar Merah (Large)",
      "originalPrice": 300000,
      "discountPrice": 150000,
      "discount": 50,
      "image": "assets/images/artifical_flowers (1).jpg",
      "stock": 10,
      "description": "Flash Sale! Diskon 50%! Bouquet bunga artificial yang awet dan cantik."
    },
    {
      "name": "Hampers Piring Coklat",
      "originalPrice": 350000,
      "discountPrice": 245000,
      "discount": 30,
      "image": "assets/images/hampers (1).jpg",
      "stock": 10,
      "description": "Diskon 30%! Hampers dengan kemasan cantik berisi berbagai snack pilihan."
    },
    {
      "name": "Papan Bunga Wedding",
      "originalPrice": 500000,
      "discountPrice": 400000,
      "discount": 20,
      "image": "assets/images/papan_bunga (1).jpg",
      "stock": 5,
      "description": "Diskon 20%! Papan bunga dengan ucapan selamat, cocok untuk perayaan."
    },
    {
      "name": "GiftBox Mawar Merah",
      "originalPrice": 185000,
      "discountPrice": 129500,
      "discount": 30,
      "image": "assets/images/gift_box (1).jpg",
      "stock": 10,
      "description": "Diskon 30%! GiftBox berisi mawar merah segar, cocok untuk hadiah spesial."
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining.inSeconds > 0) {
          _timeRemaining = _timeRemaining - const Duration(seconds: 1);
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  String _formatRupiah(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  void _addToCart(Map<String, dynamic> product) {
    final newProduct = Product(
      name: product['name'],
      price: product['discountPrice'],
      stock: product['stock'],
      image: product['image'],
      quantity: 1,
      description: product['description'],
    );

    CartService().add(newProduct);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${newProduct.name} ditambahkan ke keranjang 🛒"),
        backgroundColor: Colors.pink[300],
      ),
    );
  }

  void _claimVoucher(String code) {
    final voucherService = VoucherService();
    
    if (voucherService.isVoucherClaimed(code)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Voucher sudah di-claim sebelumnya!"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final success = voucherService.claimVoucher(code);
    if (success) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Voucher $code berhasil di-claim! 🎉"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _copyVoucherCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Kode $code berhasil disalin!"),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final voucherService = VoucherService();
    final availableVouchers = voucherService.availableVouchers;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text(
          'Promo & Diskon',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Flash Sale
            _buildFlashSaleSection(),
            
            const SizedBox(height: 16),
            
            // Section 2: Voucher
            _buildVoucherSection(availableVouchers),
            
            const SizedBox(height: 16),
            
            // Section 3: Produk Diskon
            _buildDiscountProductsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildFlashSaleSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink[400]!, Colors.pink[200]!],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            '🔥 FLASH SALE 🔥',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Diskon hingga 50%!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timer, color: Colors.pink),
                const SizedBox(width: 8),
                Text(
                  'Berakhir dalam: ${_formatTime(_timeRemaining)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: flashSaleProducts.length,
              itemBuilder: (context, index) {
                final product = flashSaleProducts[index];
                return _buildFlashSaleCard(product);
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFlashSaleCard(Map<String, dynamic> product) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    product['image'],
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '-${product['discount']}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${_formatRupiah(product['originalPrice'])}',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    'Rp ${_formatRupiah(product['discountPrice'])}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _addToCart(product),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[300],
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                      child: const Text(
                        'Beli',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoucherSection(List vouchers) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.local_offer, color: Colors.pink, size: 28),
              SizedBox(width: 8),
              Text(
                'Voucher & Promo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...vouchers.map((voucher) => _buildVoucherCard(voucher)).toList(),
        ],
      ),
    );
  }

  Widget _buildVoucherCard(voucher) {
    final voucherService = VoucherService();
    final isClaimed = voucherService.isVoucherClaimed(voucher.code);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isClaimed
              ? [Colors.grey[300]!, Colors.grey[100]!]
              : [Colors.pink[100]!, Colors.pink[50]!],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isClaimed ? Colors.grey : Colors.pink,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                voucher.type == 'freeship'
                    ? Icons.local_shipping
                    : Icons.discount,
                color: isClaimed ? Colors.grey : Colors.pink,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucher.code,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isClaimed ? Colors.grey : Colors.black,
                    ),
                  ),
                  Text(
                    voucher.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isClaimed ? Colors.grey : Colors.pink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    voucher.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: isClaimed ? Colors.grey : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                ElevatedButton(
                  onPressed: isClaimed ? null : () => _claimVoucher(voucher.code),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isClaimed ? Colors.grey : Colors.pink,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Text(
                    isClaimed ? 'Claimed' : 'Claim',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                TextButton(
                  onPressed: () => _copyVoucherCode(voucher.code),
                  child: const Text(
                    'Salin',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountProductsSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.local_offer, color: Colors.pink, size: 28),
              SizedBox(width: 8),
              Text(
                'Semua Produk Diskon',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: flashSaleProducts.length,
            itemBuilder: (context, index) {
              final product = flashSaleProducts[index];
              return _buildDiscountCard(product);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountCard(Map<String, dynamic> product) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  product['image'],
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '-${product['discount']}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Rp ${_formatRupiah(product['originalPrice'])}',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
                Text(
                  'Rp ${_formatRupiah(product['discountPrice'])}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.add_shopping_cart, color: Colors.pink),
                    onPressed: () => _addToCart(product),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}