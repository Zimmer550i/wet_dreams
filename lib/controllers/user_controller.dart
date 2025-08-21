import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:wet_dreams/models/notification.dart';
import 'package:wet_dreams/models/user.dart';
import 'package:wet_dreams/services/api_service.dart';
import 'package:wet_dreams/services/shared_prefs_service.dart';

class UserController extends GetxController {
  final userInfo = Rxn<User>();
  final api = ApiService();
  final RxnString privacyPolicy = RxnString();
  final RxList<Notification> notifications = RxList();
  final RxInt unreadNotifications = RxInt(0);
  final notificationRefreshTime = Duration(minutes: 10);

  RxBool isLoading = RxBool(false);
  Timer? _notificationTimer;

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

  Future<String> deleteUserAccount() async {
    isLoading.value = true;
    try {
      final response = await api.get(
        "/api-apps/delete_user/",
        authReq: true,
      );

      if (response.statusCode == 200) {

        return "success";
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      isLoading(false);
    }
  }

  Future<String> _getNotifications() async {
    try {
      final response = await api.get(
        "/api-apps/ViewAllNotification/",
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        notifications.clear();
        int count = 0;

        final data = body['notifications'];

        for (var i in data) {
          if (!i["is_read"]) {
            count++;
          }
          notifications.add(Notification.fromJson(i));
        }

        unreadNotifications.value = count;

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> readNotifications({String? id}) async {
    try {
      Map<String, dynamic> payload = {};

      if (id != null) {
        payload.addAll({"notification_id": id});
      }

      final response = await api.post(
        "/api-apps/MarkNotificationAsRead/",
        payload,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (id == null) {
          unreadNotifications.value = 0;
        } else {
          unreadNotifications.value = max(unreadNotifications.value - 1, 0);
        }

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  void _startNotificationTimer() {
    _notificationTimer?.cancel();

    _notificationTimer = Timer.periodic(notificationRefreshTime, (timer) {
      _getNotifications();
    });
  }

  void _stopNotificationTimer() {
    _notificationTimer?.cancel();
    _notificationTimer = null;
  }

  Future<String> refreshNotifications() async {
    _stopNotificationTimer();
    final result = await _getNotifications();
    _startNotificationTimer();
    return result;
  }

  @override
  void onClose() {
    _stopNotificationTimer();
    super.onClose();
  }
}
