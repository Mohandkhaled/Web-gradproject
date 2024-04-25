class AnomalyData {
  final List<double> anomalyScoresSvm;
  final List<double> anomalyScoresIforest;
  final List<int> clusterLabelsKmeans;

  AnomalyData({
    required this.anomalyScoresSvm,
    required this.anomalyScoresIforest,
    required this.clusterLabelsKmeans,
  });

  factory AnomalyData.fromJson(Map<String, dynamic> json) {
    return AnomalyData(
      anomalyScoresSvm: List<double>.from(json['anomaly_scores_svm']),
      anomalyScoresIforest: List<double>.from(json['anomaly_scores_iforest']),
      clusterLabelsKmeans: List<int>.from(json['cluster_labels_kmeans']),
    );
  }
}
