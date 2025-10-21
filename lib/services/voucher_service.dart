import '../models/voucher.dart';

class VoucherService {
  static final VoucherService _instance = VoucherService._internal();
  factory VoucherService() => _instance;
  VoucherService._internal();

  // Daftar voucher yang tersedia
  final List<Voucher> _availableVouchers = [
    Voucher(
      code: 'DISC50K',
      title: 'Diskon Rp 50.000',
      description: 'Diskon Rp 50.000 untuk pembelian minimal Rp 300.000',
      discountAmount: 50000,
      minPurchase: 300000,
      validUntil: DateTime.now().add(const Duration(days: 30)),
      type: 'nominal',
    ),
    Voucher(
      code: 'FREESHIP',
      title: 'Gratis Ongkir',
      description: 'Gratis ongkir untuk pembelian minimal Rp 200.000',
      minPurchase: 200000,
      validUntil: DateTime.now().add(const Duration(days: 30)),
      type: 'freeship',
    ),
    Voucher(
      code: 'NEWUSER20',
      title: 'Diskon 20% Pengguna Baru',
      description: 'Diskon 20% untuk pengguna baru (maksimal Rp 100.000)',
      discountPercent: 20,
      minPurchase: 100000,
      validUntil: DateTime.now().add(const Duration(days: 7)),
      type: 'percent',
    ),
    Voucher(
      code: 'HEMAT30',
      title: 'Hemat 30%',
      description: 'Diskon 30% untuk semua produk (maksimal Rp 150.000)',
      discountPercent: 30,
      minPurchase: 150000,
      validUntil: DateTime.now().add(const Duration(days: 14)),
      type: 'percent',
    ),
    Voucher(
      code: 'FLASH100K',
      title: 'Flash Sale Rp 100.000',
      description: 'Diskon Rp 100.000 untuk pembelian minimal Rp 500.000',
      discountAmount: 100000,
      minPurchase: 500000,
      validUntil: DateTime.now().add(const Duration(hours: 24)),
      type: 'nominal',
    ),
  ];

  // Voucher yang sudah di-claim oleh user
  final List<Voucher> _claimedVouchers = [];

  // Getter
  List<Voucher> get availableVouchers => _availableVouchers
      .where((v) => v.isValid && !v.isClaimed)
      .toList();

  List<Voucher> get claimedVouchers => _claimedVouchers;

  // Claim voucher
  bool claimVoucher(String code) {
    final index = _availableVouchers.indexWhere((v) => v.code == code);
    if (index >= 0 && !_availableVouchers[index].isClaimed) {
      _availableVouchers[index].isClaimed = true;
      _claimedVouchers.add(_availableVouchers[index]);
      return true;
    }
    return false;
  }

  // Check apakah voucher sudah di-claim
  bool isVoucherClaimed(String code) {
    return _claimedVouchers.any((v) => v.code == code);
  }

  // Get voucher by code
  Voucher? getVoucherByCode(String code) {
    try {
      return _claimedVouchers.firstWhere((v) => v.code == code && v.isValid);
    } catch (e) {
      return null;
    }
  }

  // Apply voucher ke total belanja
  int applyVoucher(String code, int totalPrice) {
    final voucher = getVoucherByCode(code);
    if (voucher != null) {
      return voucher.calculateDiscount(totalPrice);
    }
    return 0;
  }
}