class Voucher {
  final String code;
  final String title;
  final String description;
  final int discountAmount; // dalam Rupiah, 0 jika persentase
  final int discountPercent; // dalam persen, 0 jika nominal
  final int minPurchase; // minimum pembelian
  final DateTime validUntil;
  final String type; // 'nominal' atau 'percent' atau 'freeship'
  bool isClaimed;

  Voucher({
    required this.code,
    required this.title,
    required this.description,
    this.discountAmount = 0,
    this.discountPercent = 0,
    required this.minPurchase,
    required this.validUntil,
    required this.type,
    this.isClaimed = false,
  });

  // Check apakah voucher masih valid
  bool get isValid => DateTime.now().isBefore(validUntil);

  // Hitung diskon berdasarkan total belanja
  int calculateDiscount(int totalPrice) {
    if (!isValid) return 0;
    if (totalPrice < minPurchase) return 0;

    if (type == 'nominal') {
      return discountAmount;
    } else if (type == 'percent') {
      return (totalPrice * discountPercent / 100).round();
    } else if (type == 'freeship') {
      return 0; // handled differently in checkout
    }
    return 0;
  }

  // Format deskripsi untuk tampilan
  String get formattedDiscount {
    if (type == 'nominal') {
      return 'Diskon Rp ${_formatRupiah(discountAmount)}';
    } else if (type == 'percent') {
      return 'Diskon $discountPercent%';
    } else if (type == 'freeship') {
      return 'Gratis Ongkir';
    }
    return '';
  }

  String _formatRupiah(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'title': title,
        'description': description,
        'discountAmount': discountAmount,
        'discountPercent': discountPercent,
        'minPurchase': minPurchase,
        'validUntil': validUntil.toIso8601String(),
        'type': type,
        'isClaimed': isClaimed,
      };

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      code: json['code'],
      title: json['title'],
      description: json['description'],
      discountAmount: json['discountAmount'] ?? 0,
      discountPercent: json['discountPercent'] ?? 0,
      minPurchase: json['minPurchase'],
      validUntil: DateTime.parse(json['validUntil']),
      type: json['type'],
      isClaimed: json['isClaimed'] ?? false,
    );
  }
}