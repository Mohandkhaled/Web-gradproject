import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetectAnomaliesPage extends StatefulWidget {
  @override
  _DetectAnomaliesPageState createState() => _DetectAnomaliesPageState();
}

class _DetectAnomaliesPageState extends State<DetectAnomaliesPage> {
  Map<String, int> anomalyCounts = {};

  Future<void> fetchData(String endpoint) async {
    try {
      final Uri uri = Uri.parse('http://127.0.0.1:5000/$endpoint');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        setState(() {
          anomalyCounts = Map<String, int>.from(responseData);
        });

        // Show dialog with fetched data
        _showAnomalyCountsDialog(anomalyCounts);
      } else {
        throw Exception('Failed to fetch data (${response.statusCode})');
      }
    } catch (e) {
      print('Error fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch data. Please try again.'),
        ),
      );
    }
  }

  void _showAnomalyCountsDialog(Map<String, int> counts) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Anomaly Counts'),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              children: counts.entries.map((entry) {
                return ListTile(
                  title: Text(entry.key),
                  subtitle: Text('Count: ${entry.value}'),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anomaly Detection Counts'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Anomaly Detection Counts',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView(
                children: [
                  ElevatedButton(
                    onPressed: () => fetchData('processed_data/svm'),
                    child: Text('View One-Class SVM Results'),
                  ),
                  ElevatedButton(
                    onPressed: () => fetchData('processed_data/isoforest'),
                    child: Text('View Isolation Forest Results'),
                  ),
                  ElevatedButton(
                    onPressed: () => fetchData('processed_data/kmeans'),
                    child: Text('View K-Means Results'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
