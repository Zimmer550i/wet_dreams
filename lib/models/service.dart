class Service {
  final String serviceId;
  final String icon;
  final String title;
  final String? shortDescription;
  final String type;

  Service({
    required this.serviceId,
    required this.icon,
    required this.title,
    this.shortDescription,
    required this.type,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceId: json['service_id'] as String,
      icon: json['icon'] as String,
      title: json['title'] as String,
      shortDescription: json['short_description'] as String?,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'icon': icon,
      'title': title,
      'short_description': shortDescription,
      'type': type,
    };
  }
}