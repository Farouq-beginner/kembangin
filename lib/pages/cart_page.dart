import 'package:flutter/material.dart';
import '../widgets/beflorist_drawer.dart';
import '../models/user.dart';
import '../models/product.dart';
import '../services/cart_service.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  final User currentUser;

  const CartPage({super.key, required this.currentUser});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Product> cartItems = [];
  Set<int> selectedItems = {}; // Menyimpan index item yang dipilih
  bool selectAll = false;

  // Fungsi untuk format Rupiah dengan titik pemisah ribuan
  String formatRupiah(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  void _loadCart() {
    setState(() {
      cartItems = CartService().cartItems;
      // Auto select semua item saat pertama load
      selectedItems = Set.from(List.generate(cartItems.length, (i) => i));
      selectAll = cartItems.isNotEmpty;
    });
  }

  void _clearCart() {
    CartService().clearCart();
    setState(() {
      cartItems.clear();
      selectedItems.clear();
      selectAll = false;
    });
  }

  void _removeAt(int index) async {
    final productName = cartItems[index].name;
    
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text("Hapus Produk?"),
        content: Text("Apakah Anda yakin ingin menghapus '$productName' dari keranjang?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(c, true),
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    
    if (ok == true) {
      setState(() {
        CartService().removeAt(index);
        cartItems.removeAt(index);
        selectedItems.remove(index);
        // Update index yang lebih besar
        selectedItems = selectedItems.map((i) => i > index ? i - 1 : i).toSet();
        if (cartItems.isEmpty) selectAll = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$productName dihapus dari keranjang"),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _toggleSelectAll() {
    setState(() {
      selectAll = !selectAll;
      if (selectAll) {
        selectedItems = Set.from(List.generate(cartItems.length, (i) => i));
      } else {
        selectedItems.clear();
      }
    });
  }

  void _toggleSelection(int index) {
    setState(() {
      if (selectedItems.contains(index)) {
        selectedItems.remove(index);
        selectAll = false;
      } else {
        selectedItems.add(index);
        if (selectedItems.length == cartItems.length) {
          selectAll = true;
        }
      }
    });
  }

  int get totalPrice {
    int total = 0;
    for (int index in selectedItems) {
      if (index < cartItems.length) {
        final p = cartItems[index];
        total += p.price * p.quantity;
      }
    }
    return total;
  }

  List<Product> get selectedProducts {
    return selectedItems
        .where((index) => index < cartItems.length)
        .map((index) => cartItems[index])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BefloristDrawer(
        selectedIndex: 2,
        currentUser: widget.currentUser,
        onItemSelected: (_) {},
      ),
      appBar: AppBar(
        title: const Text("Keranjang"),
        backgroundColor: Colors.pink[300],
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: cartItems.isEmpty
                ? null
                : () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (c) => AlertDialog(
                        title: const Text("Kosongkan Keranjang?"),
                        content: const Text("Apakah Anda yakin ingin mengosongkan seluruh keranjang?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(c, false),
                            child: const Text("Batal"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(c, true),
                            child: const Text("Ya", style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                    if (ok == true) {
                      _clearCart();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Keranjang dikosongkan"),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: cartItems.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Keranjang masih kosong",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  // Select All Checkbox
                  Card(
                    color: Colors.pink[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CheckboxListTile(
                      value: selectAll,
                      onChanged: (_) => _toggleSelectAll(),
                      title: Text(
                        selectAll ? "Batalkan Pilih Semua" : "Pilih Semua",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      activeColor: Colors.pink[300],
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Total Harga Card
                  Card(
                    color: Colors.pink[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Harga",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Rp ${formatRupiah(totalPrice)}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${selectedItems.length} item dipilih",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Product List
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final p = cartItems[index];
                        final isSelected = selectedItems.contains(index);
                        
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: isSelected ? Colors.pink[300]! : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                // Checkbox
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (_) => _toggleSelection(index),
                                  activeColor: Colors.pink[300],
                                ),
                                // Gambar Produk
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    p.image,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Nama Produk & Quantity
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        p.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          IconButton(
                                            constraints: const BoxConstraints(),
                                            padding: EdgeInsets.zero,
                                            icon: const Icon(
                                              Icons.remove_circle_outline,
                                              color: Colors.pink,
                                              size: 24,
                                            ),
                                            onPressed: () {
                                              if (p.quantity > 1) {
                                                setState(() {
                                                  p.quantity--;
                                                });
                                              }
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text(
                                              '${p.quantity}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            constraints: const BoxConstraints(),
                                            padding: EdgeInsets.zero,
                                            icon: const Icon(
                                              Icons.add_circle_outline,
                                              color: Colors.pink,
                                              size: 24,
                                            ),
                                            onPressed: () {
                                              if (p.quantity < p.stock) {
                                                setState(() {
                                                  p.quantity++;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Harga & Tombol Delete
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Rp ${formatRupiah(p.price * p.quantity)}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    IconButton(
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.only(top: 8),
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 24,
                                      ),
                                      onPressed: () => _removeAt(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Checkout Button
                  ElevatedButton(
                    onPressed: selectedItems.isEmpty
                        ? null
                        : () {
                            if (selectedProducts.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Pilih minimal 1 produk untuk checkout"),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                              return;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    CheckoutPage(cartItems: selectedProducts),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: selectedItems.isEmpty ? Colors.grey : Colors.pink,
                    ),
                    child: Text(
                      selectedItems.isEmpty 
                          ? "Pilih Produk untuk Checkout" 
                          : "Checkout (${selectedItems.length} item)",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}