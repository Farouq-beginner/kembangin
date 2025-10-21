// lib/pages/checkout_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/product.dart';
import '../services/notification_service.dart';

class CheckoutPage extends StatefulWidget {
  final List<Product> cartItems;

  const CheckoutPage({super.key, required this.cartItems});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final NumberFormat currency =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  int get totalPrice =>
      widget.cartItems.fold(0, (sum, p) => sum + (p.price * p.quantity));

  String get formattedDate =>
      DateFormat('dd/MM/yyyy – HH:mm').format(DateTime.now());

  void _processPayment() {
    // Generate Order ID sederhana
    final orderId = 'BF${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';

    // Kirim notifikasi dengan data order lengkap
    NotificationService().createOrderNotification(
      orderId: orderId,
      orderTotal: currency.format(totalPrice),
      orderItems: List.from(widget.cartItems),
      totalPrice: totalPrice,
    );

    // Tampilkan notifikasi sukses
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✅ Pembayaran berhasil! Terima kasih telah berbelanja 💐"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Kembali ke halaman sebelumnya setelah delay
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // kembali ke cart
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Struk Pembelian'),
        backgroundColor: Colors.pink[300],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(1, 2),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header toko
                Center(
                  child: Column(
                    children: [
                      const Text(
                        "🪻 BEFLORIST 🪻",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formattedDate,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Divider(thickness: 1, color: Colors.black54),
                    ],
                  ),
                ),
                // Daftar produk
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final p = widget.cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "${p.name} x${p.quantity}",
                                style: const TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(currency.format(p.price * p.quantity)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Divider(thickness: 1.2, color: Colors.black87),
                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Bayar:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      currency.format(totalPrice),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Tombol Bayar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.payment, color: Colors.white),
                    label: const Text(
                      "Bayar Sekarang",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[400],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _processPayment,
                  ),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    "Terima kasih sudah berbelanja di Beflorist 💕",
                    style: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}