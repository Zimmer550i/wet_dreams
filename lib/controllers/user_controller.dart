import 'dart:convert';
import 'package:get/get.dart';
import 'package:wet_dreams/models/user.dart';
import 'package:wet_dreams/services/api_service.dart';
import 'package:wet_dreams/services/shared_prefs_service.dart';

class UserController extends GetxController {
  final userInfo = Rxn<User>();
  final api = ApiService();
  final RxnString privacyPolicy = RxnString();

  RxBool isLoading = RxBool(false);

  Future<String> getInfo() async {
    isLoading.value = true;
    try {
      final response = await api.get("/api-auth/user_profile/", authReq: true);
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setInfo(body);

        isLoading.value = false;
        return "success";
      } else {
        isLoading.value = false;
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      isLoading.value = false;
      return "Unexpected error: ${e.toString()}";
    }
  }

  void setInfo(Map<String, dynamic>? json) {
    if (json != null) {
      userInfo.value = User.fromJson(json);
    }
  }

  Future<String> updateInfo(Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final response = await api.patch(
        "/api-auth/update_profile/",
        data,
        authReq: true,
      );

      if (response.statusCode == 200) {
        setInfo(jsonDecode(response.body)['data']);
        isLoading.value = false;
        return "success";
      } else {
        isLoading.value = false;
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      isLoading.value = false;
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> changePassword(
    String oldPass,
    String newPass,
    String conPass,
  ) async {
    isLoading.value = true;
    try {
      final response = await api.post("/api-auth/change_password/", {
        "old_password": oldPass,
        "new_password": newPass,
        "confirm_password": conPass,
      }, authReq: true);

      if (response.statusCode == 200) {
        isLoading.value = false;
        return "success";
      } else {
        isLoading.value = false;
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      isLoading.value = false;
      return "Unexpected error: ${e.toString()}";
    }
  }

  String? getImageUrl() {
    if (userInfo.value == null || userInfo.value!.profilePic == null) {
      return null;
    }

    String baseUrl = api.baseUrl;

    return baseUrl + userInfo.value!.profilePic!;
  }

  Future<String> getPrivacyPolicy() async {
    isLoading.value = true;
    try {
      final response = await SharedPrefsService().cacheResponse(
        key: "privacy",
        frequency: CacheFrequency.oneDay,
        fetchCallback:
            () => api.get("/api-apps/privacy_policies/", authReq: true),
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        privacyPolicy.value = body['data'][0]['content'];

        isLoading.value = false;
        return "success";
      } else {
        isLoading.value = false;
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      isLoading.value = false;
      return "Unexpected error: ${e.toString()}";
    }
  }
}
