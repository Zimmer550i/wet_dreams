class Notification {
  final String id;
  // final String user;
  final String type;
  final String message;
  final bool isRead;
  final DateTime createdAt;
  final String? actionUrl;

  Notification({
    required this.id,
    // required this.user,
    required this.type,
    required this.message,
    required this.isRead,
    required this.createdAt,
    this.actionUrl,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['notification_id'],
      // user: json['user'],
      type: json['type'],
      message: json['message'],
      isRead: json['is_read'],
      createdAt: DateTime.parse(json['created_at']),
      actionUrl: json['action_url'] == '' ? null : json['action_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'user': user,
      'type': type,
      'message': message,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
      'action_url': actionUrl ?? '',
    };
  }
}