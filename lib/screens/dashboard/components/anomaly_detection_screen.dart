import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnomalyDetectionScreen extends StatefulWidget {
  @override
  _AnomalyDetectionScreenState createState() => _AnomalyDetectionScreenState();
}

class _AnomalyDetectionScreenState extends State<AnomalyDetectionScreen> {
  Map<String, dynamic>? results;
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchAnomalyDetectionResults();
  }

  Future<void> fetchAnomalyDetectionResults() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:5000'));
      if (response.statusCode == 200) {
        setState(() {
          results = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load data: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anomaly Detection Results'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : error.isNotEmpty
              ? _buildErrorWidget()
              : results != null
                  ? _buildResultsWidget()
                  : Center(
                      child: Text('No Results'),
                    ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'An Error Occurred',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          Text(
            error,
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Anomaly Detection Results',
            style: TextStyle(fontSize: 24),
          ),
          // Display results here using results map
          // Customize the layout as needed
          // Example:
          Text('Isolation Forest Anomaly Scores: ${results!['anomaly_scores_iforest']}'),
          Text('SVM Anomaly Scores: ${results!['anomaly_scores_svm']}'),
          Text('Cluster Labels: ${results!['cluster_labels']}'),
        ],
      ),
    );
  }
}
