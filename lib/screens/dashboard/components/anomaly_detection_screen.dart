import 'package:flutter/material.dart';
import 'package:gradproject/models/anomaly_data.dart';
import 'package:gradproject/services/api_services.dart';


class AnomalyDetectionScreen extends StatefulWidget {
  @override
  _AnomalyDetectionScreenState createState() => _AnomalyDetectionScreenState();
}

class _AnomalyDetectionScreenState extends State<AnomalyDetectionScreen> {
  late Future<AnomalyData> _anomalyData;

  final String baseUrl = 'http://192.168.1.22:5000'; // Update with your Flask API URL

  Map<String, dynamic> _formData = {
    'timestamp': '',
    'eventType': '',
    'contentId': '',
    'personId': '',
    'sessionId': '',
    'userAgent': '',
    'userRegion': '',
    'userCountry': '',
  };

  @override
  void initState() {
    super.initState();
    _anomalyData = ApiService(baseUrl).fetchAnomalyData(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anomaly Detection Results'),
      ),
      body: Center(
        child: FutureBuilder<AnomalyData>(
          future: _anomalyData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Anomaly Scores (SVM): ${snapshot.data!.anomalyScoresSvm}'),
                  Text('Anomaly Scores (Isolation Forest): ${snapshot.data!.anomalyScoresIforest}'),
                  Text('Cluster Labels (KMeans): ${snapshot.data!.clusterLabelsKmeans}'),
                  // Display other anomaly detection data as needed
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Update form data and fetch anomaly data
          setState(() {
            _anomalyData = ApiService(baseUrl).fetchAnomalyData(_formData);
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
