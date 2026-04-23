import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardProvider with ChangeNotifier {
  List diseases = [];
  Map tip = {};
  bool isLoading = true;

  final String apiUrl =
      "http://192.168.1.13/kesehatan_api/dashboard.php";

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        diseases = data["diseases"];
        tip = data["tips"];
      }
    } catch (e) {
      debugPrint("API Error: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
