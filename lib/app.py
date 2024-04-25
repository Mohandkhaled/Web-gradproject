from flask import Flask, render_template, request, redirect, url_for
from flask_cors import CORS  # Import CORS from flask_cors
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import IsolationForest
from sklearn.svm import OneClassSVM
from sklearn.cluster import KMeans
from sklearn.metrics import f1_score, confusion_matrix
import seaborn as sns
import matplotlib.pyplot as plt

app = Flask(__name__)
CORS(app)  # Enable CORS for all origins by default

# Home page - Upload Dataset
@app.route('/', methods=['GET', 'POST'])
def upload_dataset():
    if request.method == 'POST':
        file = request.files['file']
        if file:
            try:
                data = pd.read_csv(file)
                return perform_anomaly_detection(data)
            except Exception as e:
                return render_template('error.html', error=str(e))
    return render_template('upload.html')

# Perform Anomaly Detection
def perform_anomaly_detection(data):
    try:
        # Perform calculations and anomaly detection
        processed_data = process_data(data)
        return render_template('results.html', data=processed_data)
    except Exception as e:
        return render_template('error.html', error=str(e))

# Process Data and Perform Anomaly Detection
def process_data(data):
    # Your data processing and anomaly detection code
    features = ['time_since_last_event_user', 'time_since_last_event_content',
                'time_since_last_session', 'average_time_between_interactions',
                'session_duration', 'average_session_duration_user']

    # Preprocessing
    X = data[features].copy()
    X.fillna(X.mean(), inplace=True)
    X[features] = X[features].apply(pd.to_timedelta)
    X[features] = X[features].apply(lambda x: x.dt.total_seconds())
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)

    # Anomaly detection using Isolation Forest
    model_iforest = IsolationForest(contamination=0.05)
    model_iforest.fit(X_scaled)
    anomaly_scores_iforest = model_iforest.decision_function(X_scaled)

    # Anomaly detection using OneClassSVM
    model_svm = OneClassSVM(nu=0.05)
    model_svm.fit(X_scaled)
    anomaly_scores_svm = model_svm.decision_function(X_scaled)

    # Anomaly detection using K-Means
    kmeans = KMeans(n_clusters=2)
    cluster_labels = kmeans.fit_predict(X_scaled)

    # Evaluate anomaly detection results
    results = {
        'anomaly_scores_iforest': anomaly_scores_iforest,
        'anomaly_scores_svm': anomaly_scores_svm,
        'cluster_labels': cluster_labels
    }
    return results

# Error page
@app.route('/error')
def error_page():
    return render_template('error.html')

if __name__ == '__main__':
    app.run(debug=True)
