import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../models/product.dart';
import '../../services/cart_service.dart';

class BestSellerPage extends StatefulWidget {
  final User currentUser;

  const BestSellerPage({super.key, required this.currentUser});

  @override
  State<BestSellerPage> createState() => _BestSellerPageState();
}

class _BestSellerPageState extends State<BestSellerPage> {
  String selectedPeriod = 'Bulan';
  String selectedCategory = 'Semua';

  final List<Map<String, dynamic>> allBestSellers = [
    {
      "rank": 1,
      "name": "Buket Artificial Mawar Merah (Large)",
      "price": 300000,
      "image": "assets/images/artifical_flowers (1).jpg",
      "stock": 10,
      "totalSold": 2340,
      "category": "Bouquet",
      "description": "Bouquet bunga artificial yang awet dan cantik, cocok untuk dekorasi dan hadiah jangka panjang.",
    },
    {
      "rank": 2,
      "name": "Mawar Merah",
      "price": 20000,
      "image": "assets/images/mawar_merah.png",
      "stock": 20,
      "totalSold": 1850,
      "category": "Fresh Flowers",
      "description": "Mawar merah segar dengan aroma khas, simbol cinta dan kasih sayang yang mendalam.",
    },
    {
      "rank": 3,
      "name": "Hampers Piring Coklat",
      "price": 350000,
      "image": "assets/images/hampers (1).jpg",
      "stock": 10,
      "totalSold": 1420,
      "category": "Hampers",
      "description": "Hampers dengan kemasan cantik berisi berbagai snack pilihan.",
    },
    {
      "rank": 4,
      "name": "GiftBox Mawar Merah",
      "price": 185000,
      "image": "assets/images/gift_box (1).jpg",
      "stock": 10,
      "totalSold": 1230,
      "category": "GiftBox",
      "description": "GiftBox berisi mawar merah segar, cocok untuk hadiah spesial.",
    },
    {
      "rank": 5,
      "name": "Buket Fresh Flowers Mawar Pink (Large)",
      "price": 190000,
      "image": "assets/images/fresh_flowers (12).jpg",
      "stock": 9,
      "totalSold": 980,
      "category": "Bouquet",
      "description": "Bouquet bunga segar pilihan, wangi alami dan penuh warna.",
    },
    {
      "rank": 6,
      "name": "Lily Putih",
      "price": 30000,
      "image": "assets/images/lily_putih.png",
      "stock": 12,
      "totalSold": 890,
      "category": "Fresh Flowers",
      "description": "Lily putih elegan dengan aroma lembut, cocok untuk dekorasi atau acara resmi.",
    },
    {
      "rank": 7,
      "name": "Papan Bunga Wedding",
      "price": 500000,
      "image": "assets/images/papan_bunga (1).jpg",
      "stock": 5,
      "totalSold": 720,
      "category": "Papan Bunga",
      "description": "Papan bunga dengan ucapan selamat, cocok untuk perayaan atau opening.",
    },
    {
      "rank": 8,
      "name": "Hampers Set Cangkir",
      "price": 280000,
      "image": "assets/images/hampers (4).jpg",
      "stock": 15,
      "totalSold": 650,
      "category": "Hampers",
      "description": "Hampers elegan berisi minuman dan snack ringan.",
    },
    {
      "rank": 9,
      "name": "Buket Artificial All Flowers Mix (Large)",
      "price": 230000,
      "image": "assets/images/artifical_flowers (11).jpg",
      "stock": 9,
      "totalSold": 580,
      "category": "Bouquet",
      "description": "Bouquet bunga artificial yang awet dan cantik.",
    },
    {
      "rank": 10,
      "name": "GiftBox Coklat & Boneka",
      "price": 195000,
      "image": "assets/images/gift_box (2).jpg",
      "stock": 8,
      "totalSold": 520,
      "category": "GiftBox",
      "description": "GiftBox berisi boneka lucu dan aneka coklat manis, cocok untuk pasangan.",
    },
    {
      "rank": 11,
      "name": "Gerbera Merah",
      "price": 15000,
      "image": "assets/images/gerbera_merah.png",
      "stock": 30,
      "totalSold": 480,
      "category": "Fresh Flowers",
      "description": "Gerbera merah segar yang cerah, simbol semangat dan kebahagiaan.",
    },
    {
      "rank": 12,
      "name": "Buket Money 1 (Small)",
      "price": 350000,
      "image": "assets/images/buket_money (1).jpg",
      "stock": 5,
      "totalSold": 420,
      "category": "Bouquet",
      "description": "Harga buket sudah termasuk dengan uang.",
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    var filtered = allBestSellers;

    if (selectedCategory != 'Semua') {
      filtered = filtered
          .where((p) => p['category'] == selectedCategory)
          .toList();
    }
    
    return filtered;
  }

  List<Map<String, dynamic>> get top3Products {
    return filteredProducts.take(3).toList();
  }

  List<Map<String, dynamic>> get otherProducts {
    return filteredProducts.skip(3).toList();
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
      price: product['price'],
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

  void _showProductDetail(Map<String, dynamic> product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Badge Rank - CHANGED TO GREY
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.grey[600]!, Colors.grey[400]!],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.stars, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        'Best Seller #${product['rank']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    product['image'],
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  product['name'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Rp ${_formatRupiah(product['price'])}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.shopping_bag, color: Colors.pink),
                          const SizedBox(height: 4),
                          Text(
                            '${product['totalSold']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Text(
                            'Terjual',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(Icons.inventory, color: Colors.pink),
                          const SizedBox(height: 4),
                          Text(
                            '${product['stock']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Text(
                            'Stok',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  product['description'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[300],
                    minimumSize: const Size(200, 50),
                  ),
                  onPressed: () {
                    _addToCart(product);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text("Tambah ke Keranjang"),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text(
          'Best Seller',
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
            _buildHeroBanner(),
            _buildFilters(),
            _buildPodiumSection(),
            _buildOtherProductsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    // CHANGED TO GREY
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[600]!, Colors.grey[400]!],
        ),
      ),
      child: Column(
        children: [
          const Icon(Icons.emoji_events, size: 64, color: Colors.white),
          const SizedBox(height: 8),
          const Text(
            'BEST SELLER',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Produk Paling Laris $selectedPeriod Ini',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Periode',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Minggu', 'Bulan', 'Sepanjang Masa']
                  .map((period) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(period),
                          selected: selectedPeriod == period,
                          onSelected: (selected) {
                            setState(() {
                              selectedPeriod = period;
                            });
                          },
                          selectedColor: Colors.pink[300],
                          labelStyle: TextStyle(
                            color: selectedPeriod == period
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Kategori',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                'Semua',
                'Bouquet',
                'Fresh Flowers',
                'Hampers',
                'GiftBox',
                'Papan Bunga'
              ]
                  .map((category) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(category),
                          selected: selectedCategory == category,
                          onSelected: (selected) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                          selectedColor: Colors.pink[300],
                          labelStyle: TextStyle(
                            color: selectedCategory == category
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumSection() {
    if (top3Products.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text('Tidak ada produk best seller di kategori ini'),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            '🏆 TOP 3 BEST SELLER 🏆',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          // Podium Layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rank 2 (Left)
              if (top3Products.length > 1)
                Expanded(child: _buildPodiumCard(top3Products[1], 2)),
              const SizedBox(width: 8),
              // Rank 1 (Center - Tallest)
              Expanded(child: _buildPodiumCard(top3Products[0], 1)),
              const SizedBox(width: 8),
              // Rank 3 (Right)
              if (top3Products.length > 2)
                Expanded(child: _buildPodiumCard(top3Products[2], 3)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumCard(Map<String, dynamic> product, int rank) {
    final heights = {1: 220.0, 2: 200.0, 3: 180.0};
    // CHANGED ALL TO GREY SHADES
    final colors = {
      1: [Colors.grey[600]!, Colors.grey[400]!],
      2: [Colors.grey[500]!, Colors.grey[300]!],
      3: [Colors.grey[400]!, Colors.grey[200]!],
    };
    final icons = {1: '🥇', 2: '🥈', 3: '🥉'};

    return GestureDetector(
      onTap: () => _showProductDetail(product),
      child: Container(
        height: heights[rank],
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: colors[rank]!,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      icons[rank]!,
                      style: const TextStyle(fontSize: 32),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        product['image'],
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        product['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${product['totalSold']} terjual',
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp ${_formatRupiah(product['price'])}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherProductsList() {
    if (otherProducts.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Produk Best Seller Lainnya',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: otherProducts.length,
            itemBuilder: (context, index) {
              final product = otherProducts[index];
              return _buildListCard(product);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () => _showProductDetail(product),
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Rank Badge
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '#${product['rank']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  product['image'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp ${_formatRupiah(product['price'])}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.shopping_bag,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${product['totalSold']} terjual',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart, color: Colors.pink),
                onPressed: () => _addToCart(product),
              ),
            ],
          ),
        ),
      ),
    );
  }
}