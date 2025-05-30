class PoolVolume {
  final int id;
  final String shape;
  final double? length;
  final double? width;
  final double minDepth;
  final double maxDepth;
  final double? diameter;
  final double volumeM3;
  final double volumeLiters;
  final DateTime createdAt;

  PoolVolume({
    required this.id,
    required this.shape,
    required this.length,
    required this.width,
    required this.minDepth,
    required this.maxDepth,
    required this.diameter,
    required this.volumeM3,
    required this.volumeLiters,
    required this.createdAt,
  });

  factory PoolVolume.fromJson(Map<String, dynamic> json) {
    double? toNullableDouble(dynamic value) {
      if (value == null) return null;
      return (value as num).toDouble();
    }

    return PoolVolume(
      id: json['id'] as int,
      shape: json['shape'] as String,
      length: toNullableDouble(json['length']),
      width: toNullableDouble(json['width']),
      minDepth: (json['min_depth'] as num).toDouble(),
      maxDepth: (json['max_depth'] as num).toDouble(),
      diameter: toNullableDouble(json['diameter']),
      volumeM3: (json['volume_m3'] as num).toDouble(),
      volumeLiters: (json['volume_liters'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shape': shape,
      'length': length,
      'width': width,
      'min_depth': minDepth,
      'max_depth': maxDepth,
      'diameter': diameter,
      'volume_m3': volumeM3,
      'volume_liters': volumeLiters,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
