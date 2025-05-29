class ChemicalResult {
  final int id;
  final double pH;
  final double chlorine;
  final double alkalinity;
  final double cya;
  final double calciumHardness;
  final String resultSummary;
  final DateTime createdAt;
  final int user;

  ChemicalResult({
    required this.id,
    required this.pH,
    required this.chlorine,
    required this.alkalinity,
    required this.cya,
    required this.calciumHardness,
    required this.resultSummary,
    required this.createdAt,
    required this.user,
  });

  factory ChemicalResult.fromJson(Map<String, dynamic> json) {
    return ChemicalResult(
      id: json['id'],
      pH: (json['pH'] as num).toDouble(),
      chlorine: (json['chlorine'] as num).toDouble(),
      alkalinity: (json['alkalinity'] as num).toDouble(),
      cya: (json['cya'] as num).toDouble(),
      calciumHardness: (json['calcium_hardness'] as num).toDouble(),
      resultSummary: json['result_summary'],
      createdAt: DateTime.parse(json['created_at']),
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pH': pH,
      'chlorine': chlorine,
      'alkalinity': alkalinity,
      'cya': cya,
      'calcium_hardness': calciumHardness,
      'result_summary': resultSummary,
      'created_at': createdAt.toIso8601String(),
      'user': user,
    };
  }
}