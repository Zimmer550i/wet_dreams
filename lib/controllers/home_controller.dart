import 'dart:convert';
import 'package:get/get.dart';
import 'package:wet_dreams/models/footer_model.dart';
import 'package:wet_dreams/models/item_list_model.dart';
import 'package:wet_dreams/models/item_model.dart';
import 'package:wet_dreams/models/service.dart';
import 'package:wet_dreams/services/api_service.dart';
import 'package:wet_dreams/services/shared_prefs_service.dart';

class HomeController extends GetxController {
  final api = ApiService();
  final prefs = SharedPrefsService();
  RxList<Service> homeButtons = RxList();
  RxList<ItemListModel> itemList = RxList();
  Rxn<ItemModel> item = Rxn();
  Rxn<FooterModel> footer = Rxn();

  Future<String> getServices() async {
    try {
      homeButtons = RxList.empty();
      final response = await prefs.cacheResponse(
        key: "home",
        frequency: CacheFrequency.sixHours,
        fetchCallback: () {
          return api.get("/api-apps/DashboardServices/", authReq: true);
        },
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final services = body['services'];

        for (var i in services) {
          homeButtons.add(Service.fromJson(i));
        }

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> getItems(String id) async {
    try {
      itemList = RxList.empty();
      final response = await prefs.cacheResponse(
        key: "homeItems:$id",
        frequency: CacheFrequency.sixHours,
        fetchCallback: () {
          return api.get(
            "/api-apps/ViewAllItems/",
            queryParams: {"service_id": id},
            authReq: true,
          );
        },
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final items = body['items'];

        for (var i in items) {
          itemList.add(ItemListModel.fromJson(i));
        }

        if (body['footer'] != null) {
          footer = Rxn(FooterModel.fromJson(body['footer']));
        } else {
          footer.value = null;
        }

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> getItem(String id) async {
    try {
      item = Rxn();
      final response = await prefs.cacheResponse(
        key: "item:$id",
        frequency: CacheFrequency.oneHour,
        fetchCallback: () {
          return api.get(
            "/api-apps/ViewSingleItem/",
            queryParams: {"item_id": id},
            authReq: true,
          );
        },
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        item.value = ItemModel.fromJson(body['data']);

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> sendQuery(Map<String, dynamic> payload) async {
    try {
      item = Rxn();
      final response = await api.post(
        "/api-apps/send_query/",
        payload,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var temp = ItemModel.fromJson(body['data']);

        item.value = ItemModel(
          itemId: temp.itemId,
          image: api.baseUrl + temp.image,
          title: temp.title,
          description: temp.description,
          createdAt: temp.createdAt,
          updatedAt: temp.updatedAt,
        );

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }
}
