import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gradproject/models/anomaly_data.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<AnomalyData> fetchAnomalyData(Map<String, dynamic> formData) async {
    final url = Uri.parse('$baseUrl/detect-anomalies');
    final response = await http.post(
      url,
      body: formData,
    );

    if (response.statusCode == 200) {
      return AnomalyData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load anomaly data: ${response.statusCode}');
    }
  }
}
