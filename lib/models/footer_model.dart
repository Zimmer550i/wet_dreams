class FooterModel {
  final String footerTitle;
  final String footerUrl;

  FooterModel({
    required this.footerTitle,
    required this.footerUrl,
  });

  // Factory constructor to create an instance from JSON
  factory FooterModel.fromJson(Map<String, dynamic> json) {
    return FooterModel(
      footerTitle: json['footer_title'] as String,
      footerUrl: json['footer_url'] as String,
    );
  }

  // Method to convert instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'footer_title': footerTitle,
      'footer_url': footerUrl,
    };
  }
}