class ChemicalResult {
  final int id;
  final InputValues inputValues;
  final Map<String, dynamic> adjustments;
  final DateTime createdAt;

  ChemicalResult({
    required this.id,
    required this.inputValues,
    required this.adjustments,
    required this.createdAt,
  });

  factory ChemicalResult.fromJson(Map<String, dynamic> json) {
    return ChemicalResult(
      id: int.parse(json['id']),
      inputValues: InputValues.fromJson(json['input_values']),
      adjustments: Map<String, dynamic>.from(json['adjustments']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'input_values': inputValues.toJson(),
      'adjustments': adjustments,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class InputValues {
  final String pH;
  final String chlorine;
  final String alkalinity;
  final String cya;
  final String calciumHardness;
  final String poolVolumeM3;

  InputValues({
    required this.pH,
    required this.chlorine,
    required this.alkalinity,
    required this.cya,
    required this.calciumHardness,
    required this.poolVolumeM3,
  });

  factory InputValues.fromJson(Map<String, dynamic> json) {
    return InputValues(
      pH: json['pH'],
      chlorine: json['chlorine'],
      alkalinity: json['alkalinity'],
      cya: json['cya'],
      calciumHardness: json['calcium_hardness'],
      poolVolumeM3: json['pool_volume_m3'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pH': pH,
      'chlorine': chlorine,
      'alkalinity': alkalinity,
      'cya': cya,
      'calcium_hardness': calciumHardness,
      'pool_volume_m3': poolVolumeM3,
    };
  }
}