import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/controllers/user_controller.dart';
import 'package:wet_dreams/services/api_service.dart';
import 'package:wet_dreams/services/shared_prefs_service.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/screens/auth/login.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = RxBool(false);
  final api = ApiService();

  Future<String> login(
    String email,
    String password, {
    bool rememberMe = true,
  }) async {
    try {
      final response = await api.post("/api-auth/login/", {
        "email": email.trim(),
        "password": password.trim(),
      });
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.find<UserController>().setInfo(body['data']);
        if (rememberMe) {
          setToken(body['access_token']);
        }

        return "success";
      } else {
        if (body['error'] == "Please verify your email address.") {
          return "verify";
        }

        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> signup(String name, String email, String password) async {
    try {
      final response = await api.post("/api-auth/signup/", {
        "full_name": name.trim(),
        "email": email.trim(),
        "password": password.trim(),
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "success";
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> sendOtp(String email) async {
    try {
      final response = await api.post("/api-auth/resend_code/", {
        "email": email.trim(),
      });

      if (response.statusCode == 200) {
        return "success";
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> verifyEmail(String email, String code) async {
    try {
      final response = await api.post("/api-auth/verify_email/", {
        "email": email.trim(),
        "otp": code.trim(),
      });
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setToken(body['access_token']);

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> resetPassword(String pass, String conPass) async {
    try {
      final response = await api.post("/api-auth/forgot_password/", {
        "new_password": pass.trim(),
        "confirm_password": conPass.trim(),
      }, authReq: true);
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<bool> previouslyLoggedIn() async {
    String? token = await SharedPrefsService.get('token');
    if (token != null) {
      debugPrint('🔍 Token found. Fetching user info...');
      final message = await Get.find<UserController>().getInfo();
      if (message == "success") {
        debugPrint("🟡 Token: $token");
        isLoggedIn.value = true;
        return true;
      }
    }
    isLoggedIn.value = false;
    return false;
  }

  Future<void> logout() async {
    await SharedPrefsService.clear();
    Get.offAll(() => Login());
    showSnackBar("You have been logged out");
    isLoggedIn.value = false;
  }

  Future<void> setToken(String value) async {
    await SharedPrefsService.set('token', value);
    debugPrint('💾 Token Saved: $value');
  }
}
