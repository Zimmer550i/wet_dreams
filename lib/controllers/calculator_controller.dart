import 'dart:convert';
import 'package:get/get.dart';
import 'package:wet_dreams/models/chemical_result.dart';
import 'package:wet_dreams/models/pool_volume.dart';
import 'package:wet_dreams/services/api_service.dart';
import 'package:wet_dreams/services/shared_prefs_service.dart';

class CalculatorController extends GetxController {
  final api = ApiService();
  final prefs = SharedPrefsService();
  Rxn<PoolVolume> poolVolume = Rxn();
  Rxn<ChemicalResult> lastResult = Rxn();
  RxList<ChemicalResult> results = RxList();

  Future<String> analyzeChemical(Map<String, double> payload) async {
    try {
      final response = await api.post(
        "/api-apps/analyze_chemicals/",
        payload,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        lastResult.value = ChemicalResult.fromJson(body['data']);

        return "success";
      } else {
        return body['message'] ?? "Connection error!";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> calculateVolume(Map<String, dynamic> payload) async {
    try {
      final response = await api.post(
        "/api-apps/calculate_volume/",
        payload,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        SharedPrefsService.remove("getVolume");
        poolVolume.value = PoolVolume.fromJson(body['data']);

        return "success";
      } else {
        return body['message'] ?? "Connection error!";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> getChemicalResults() async {
    try {
      final response = await api.get(
        "/api-apps/chemical_results/",
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        results.clear();

        final data = body['data'];

        for (var i in data) {
          results.add(ChemicalResult.fromJson(i));
        }

        return "success";
      } else {
        return body['message'] ?? "Connection error!";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> deleteChemicalResult(String id) async {
    try {
      final response = await api.delete(
        "/api-apps/pool_volume_delete/$id",
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        results.removeWhere((val) => val.id.toString() == id);
        results.refresh();

        return "success";
      } else {
        return body['message'] ?? "Connection error!";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> getVolume() async {
    try {
      // final response = await api.get("/api-apps/pool_volumes/", authReq: true);
      final response = await prefs.cacheResponse(
        key: "getVolume",
        frequency: CacheFrequency.oneDay,
        fetchCallback: () => api.get("/api-apps/pool_volumes/", authReq: true),
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        poolVolume.value = PoolVolume.fromJson(body['data']);

        return "success";
      } else {
        return body['message'] ?? "Connection error!";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }
}
