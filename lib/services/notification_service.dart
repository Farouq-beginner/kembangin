// lib/services/notification_service.dart
import '../models/notification.dart';
import '../models/product.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => List.unmodifiable(_notifications);

  // Get unread count
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  // Add notification
  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification); // Tambah di posisi pertama
  }

  // Mark as read
  void markAsRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }

  // Mark all as read
  void markAllAsRead() {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
  }

  // Delete notification
  void deleteNotification(String notificationId) {
    _notifications.removeWhere((n) => n.id == notificationId);
  }

  // Clear all notifications
  void clearAll() {
    _notifications.clear();
  }

  // Get notifications by type
  List<NotificationModel> getByType(String type) {
    return _notifications.where((n) => n.type == type).toList();
  }

  // Create order notification
  void createOrderNotification({
    required String orderId,
    required String orderTotal,
    required List<Product> orderItems,
    required int totalPrice,
  }) {
    final notification = NotificationModel(
      id: NotificationModel.generateId(),
      title: '✅ Pesanan Berhasil!',
      message: 'Pesanan #$orderId sebesar $orderTotal telah dikonfirmasi. Terima kasih telah berbelanja!',
      type: 'order',
      createdAt: DateTime.now(),
      orderId: orderId,
      icon: '🛍️',
      orderItems: orderItems,
      orderTotal: totalPrice,
    );
    addNotification(notification);
  }

  // Create promo notification
  void createPromoNotification({
    required String title,
    required String message,
  }) {
    final notification = NotificationModel(
      id: NotificationModel.generateId(),
      title: title,
      message: message,
      type: 'promo',
      createdAt: DateTime.now(),
      icon: '🎉',
    );
    addNotification(notification);
  }

  // Create info notification
  void createInfoNotification({
    required String title,
    required String message,
  }) {
    final notification = NotificationModel(
      id: NotificationModel.generateId(),
      title: title,
      message: message,
      type: 'info',
      createdAt: DateTime.now(),
      icon: 'ℹ️',
    );
    addNotification(notification);
  }
}