import 'dart:convert';

import 'package:get/get.dart';
import 'package:wet_dreams/services/api_service.dart';

class CalculatorController extends GetxController {
  final api = ApiService();

  Future<String> analyzeChemical(Map<String, double> payload) async {
    try {
      final response = await api.post(
        "/api-apps/analyze_chemicals/",
        payload,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return "success";
      } else {
        return body['message'] ?? "Connection error!";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }
}
