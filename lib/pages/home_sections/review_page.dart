import 'package:flutter/material.dart';
import '../../models/user.dart';

class ReviewPage extends StatefulWidget {
  final User currentUser;

  const ReviewPage({super.key, required this.currentUser});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int selectedRating = 0; // 0 = Semua
  String selectedCategory = 'Semua';

  // Data review simulasi
  final List<Map<String, dynamic>> allReviews = [
    {
      "id": "1",
      "userName": "Budi Santoso",
      "rating": 5,
      "productName": "Buket Artificial Mawar Merah (Large)",
      "category": "Bouquet",
      "reviewText":
          "Bunganya sangat cantik dan awet! Kemasan rapi, pengiriman cepat. Sangat puas dengan pelayanannya. Pasti order lagi!",
      "date": "2025-01-15",
      "helpfulCount": 124,
    },
    {
      "id": "2",
      "userName": "Siti Aminah",
      "rating": 5,
      "productName": "Mawar Merah",
      "category": "Fresh Flowers",
      "reviewText":
          "Mawar merahnya segar banget! Wangi dan bertahan lama. Cocok banget untuk kado romantis. Terima kasih!",
      "date": "2025-01-14",
      "helpfulCount": 98,
    },
    {
      "id": "3",
      "userName": "Andi Wijaya",
      "rating": 4,
      "productName": "Hampers Piring Coklat",
      "category": "Hampers",
      "reviewText":
          "Hampers nya bagus, isinya lengkap. Cuma sedikit lama pengirimannya tapi overall memuaskan!",
      "date": "2025-01-13",
      "helpfulCount": 76,
    },
    {
      "id": "4",
      "userName": "Dewi Lestari",
      "rating": 5,
      "productName": "GiftBox Mawar Merah",
      "category": "GiftBox",
      "reviewText":
          "GiftBox nya cantik banget! Pacar saya sangat senang. Packaging rapih dan elegan. Highly recommended!",
      "date": "2025-01-12",
      "helpfulCount": 145,
    },
    {
      "id": "5",
      "userName": "Rudi Hermawan",
      "rating": 5,
      "productName": "Papan Bunga Wedding",
      "category": "Papan Bunga",
      "reviewText":
          "Papan bunganya bagus sekali! Ukurannya besar dan bunganya segar. Tamu-tamu pada puji. Terima kasih Beflorist!",
      "date": "2025-01-11",
      "helpfulCount": 189,
    },
    {
      "id": "6",
      "userName": "Linda Kusuma",
      "rating": 4,
      "productName": "Lily Putih",
      "category": "Fresh Flowers",
      "reviewText":
          "Lily putihnya cantik dan wangi. Tapi ada beberapa yang sedikit layu. Overall masih bagus sih.",
      "date": "2025-01-10",
      "helpfulCount": 54,
    },
    {
      "id": "7",
      "userName": "Agus Prasetyo",
      "rating": 5,
      "productName": "Buket Money 1 (Small)",
      "category": "Bouquet",
      "reviewText":
          "Unik dan kreatif! Buket uangnya rapi dan cantik. Cocok banget buat kado wisuda. Harga sebanding dengan kualitas!",
      "date": "2025-01-09",
      "helpfulCount": 167,
    },
    {
      "id": "8",
      "userName": "Fitri Handayani",
      "rating": 5,
      "productName": "Hampers Set Cangkir",
      "category": "Hampers",
      "reviewText":
          "Hampers nya bagus banget! Cangkir nya lucu dan snack nya enak-enak. Kemasan juga mewah. Worth it!",
      "date": "2025-01-08",
      "helpfulCount": 92,
    },
    {
      "id": "9",
      "userName": "Hendra Gunawan",
      "rating": 3,
      "productName": "Gerbera Merah",
      "category": "Fresh Flowers",
      "reviewText":
          "Bunganya lumayan bagus, tapi tidak sesuai ekspektasi. Beberapa kelopak ada yang rusak.",
      "date": "2025-01-07",
      "helpfulCount": 23,
    },
    {
      "id": "10",
      "userName": "Yuni Astuti",
      "rating": 5,
      "productName": "Buket Artificial All Flowers Mix (Large)",
      "category": "Bouquet",
      "reviewText":
          "Buket artificial nya cantik sekali! Warna-warni dan terlihat seperti bunga asli. Sangat puas!",
      "date": "2025-01-06",
      "helpfulCount": 156,
    },
    {
      "id": "11",
      "userName": "Bambang Suryanto",
      "rating": 4,
      "productName": "GiftBox Coklat & Boneka",
      "category": "GiftBox",
      "reviewText":
          "GiftBox nya lucu! Boneka dan coklatnya berkualitas. Cuma agak mahal sih, tapi masih worth it.",
      "date": "2025-01-05",
      "helpfulCount": 67,
    },
    {
      "id": "12",
      "userName": "Rina Marlina",
      "rating": 5,
      "productName": "Tulip Pink",
      "category": "Fresh Flowers",
      "reviewText":
          "Tulip pink nya cantik banget! Segar dan wangi. Packaging juga bagus. Sangat memuaskan!",
      "date": "2025-01-04",
      "helpfulCount": 134,
    },
    {
      "id": "13",
      "userName": "Joko Widodo",
      "rating": 2,
      "productName": "Krisan Kuning",
      "category": "Fresh Flowers",
      "reviewText":
          "Agak mengecewakan. Bunga yang datang tidak segar dan ada beberapa yang sudah layu. Perlu perbaikan.",
      "date": "2025-01-03",
      "helpfulCount": 12,
    },
    {
      "id": "14",
      "userName": "Sri Mulyani",
      "rating": 5,
      "productName": "Hampers Piring + Nastar",
      "category": "Hampers",
      "reviewText":
          "Hampers nya premium! Piring cantik dan nastar nya enak. Cocok untuk hadiah lebaran. Recommended!",
      "date": "2025-01-02",
      "helpfulCount": 201,
    },
    {
      "id": "15",
      "userName": "Ahmad Dhani",
      "rating": 4,
      "productName": "Papan Bunga Grand Opening",
      "category": "Papan Bunga",
      "reviewText":
          "Papan bunganya bagus dan besar. Bunganya segar. Cuma agak telat sedikit pengirimannya.",
      "date": "2025-01-01",
      "helpfulCount": 89,
    },
  ];

  // Hitung statistik rating
  Map<String, dynamic> get ratingStats {
    final total = allReviews.length;
    final ratingCounts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    double totalRating = 0;

    for (var review in allReviews) {
      final rating = review['rating'] as int;
      ratingCounts[rating] = ratingCounts[rating]! + 1;
      totalRating += rating;
    }

    final averageRating = totalRating / total;

    return {
      'total': total,
      'average': averageRating,
      'counts': ratingCounts,
    };
  }

  // Filter reviews
  List<Map<String, dynamic>> get filteredReviews {
    var filtered = allReviews;

    // Filter by rating
    if (selectedRating > 0) {
      filtered = filtered.where((r) => r['rating'] == selectedRating).toList();
    }

    // Filter by category
    if (selectedCategory != 'Semua') {
      filtered =
          filtered.where((r) => r['category'] == selectedCategory).toList();
    }

    // Sort by helpful count (most helpful first)
    filtered.sort((a, b) => b['helpfulCount'].compareTo(a['helpfulCount']));

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final stats = ratingStats;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text(
          'Ulasan Pelanggan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewSection(stats),
            _buildFilterSection(),
            _buildReviewList(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewSection(Map<String, dynamic> stats) {
    final average = stats['average'] as double;
    final total = stats['total'] as int;
    final counts = stats['counts'] as Map<int, int>;

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
          const Icon(Icons.star, size: 64, color: Colors.amber),
          const SizedBox(height: 8),
          Text(
            average.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                index < average.round() ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 24,
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            'Dari $total ulasan',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          // Rating breakdown
          ...List.generate(5, (index) {
            final rating = 5 - index;
            final count = counts[rating]!;
            final percentage = (count / total * 100).round();

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: Text(
                      '$rating⭐',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: percentage / 100,
                        minHeight: 8,
                        backgroundColor: Colors.grey[300],
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.amber),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 60,
                    child: Text(
                      '$percentage% ($count)',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Rating',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildRatingChip('Semua', 0),
                _buildRatingChip('5⭐', 5),
                _buildRatingChip('4⭐', 4),
                _buildRatingChip('3⭐', 3),
                _buildRatingChip('2⭐', 2),
                _buildRatingChip('1⭐', 1),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Filter Kategori',
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

  Widget _buildRatingChip(String label, int rating) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selectedRating == rating,
        onSelected: (selected) {
          setState(() {
            selectedRating = rating;
          });
        },
        selectedColor: Colors.pink[300],
        labelStyle: TextStyle(
          color: selectedRating == rating ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildReviewList() {
    final reviews = filteredReviews;

    if (reviews.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: [
              Icon(Icons.rate_review_outlined, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Tidak ada ulasan',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.reviews, color: Colors.pink),
              const SizedBox(width: 8),
              Text(
                '${reviews.length} Ulasan',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return _buildReviewCard(reviews[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info & rating
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.pink[100],
                  child: Text(
                    review['userName'][0],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            review['userName'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified,
                                  size: 12,
                                  color: Colors.green[700],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Verified',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < review['rating']
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Text(
                  review['date'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Product name
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                review['productName'],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.pink,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Review text
            Text(
              review['reviewText'],
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            // Helpful count
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.thumb_up_outlined,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${review['helpfulCount']} orang merasa review ini membantu',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
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
}