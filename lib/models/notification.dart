import 'product.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type; // order, promo, info, system
  final DateTime createdAt;
  final bool isRead;
  final String? orderId; // optional, untuk notifikasi order
  final String? icon;
  final List<Product>? orderItems; // Tambahan: produk yang dibeli
  final int? orderTotal; // Tambahan: total pembayaran

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    this.isRead = false,
    this.orderId,
    this.icon,
    this.orderItems,
    this.orderTotal,
  });

  // Generate notification ID
  static String generateId() {
    final now = DateTime.now();
    return 'NOTIF${now.millisecondsSinceEpoch}';
  }

  // Copy with method untuk update isRead
  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    String? type,
    DateTime? createdAt,
    bool? isRead,
    String? orderId,
    String? icon,
    List<Product>? orderItems,
    int? orderTotal,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      orderId: orderId ?? this.orderId,
      icon: icon ?? this.icon,
      orderItems: orderItems ?? this.orderItems,
      orderTotal: orderTotal ?? this.orderTotal,
    );
  }
}