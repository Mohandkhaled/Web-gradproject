from flask import Flask, jsonify
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import IsolationForest
from sklearn.svm import OneClassSVM
from sklearn.cluster import KMeans
from flask_cors import CORS
import numpy as np
import json

app = Flask(__name__)
CORS(app)

# Load your dataset (replace the file path with your actual file path)
data = pd.read_csv('F:/S/Insiders/gradproject/data/users_interactions.csv')

# Data preprocessing and feature engineering
data['timestamp'] = pd.to_datetime(data['timestamp'])

# Sort the DataFrame by 'personId', 'contentId', and 'timestamp'
data.sort_values(['personId', 'contentId', 'timestamp'], inplace=True)

# Calculate time differences between consecutive events for each 'personId' and 'contentId'
data['time_since_last_event_user'] = data.groupby('personId')['timestamp'].diff().dt.total_seconds()
data['time_since_last_event_content'] = data.groupby('contentId')['timestamp'].diff().dt.total_seconds()
data['time_since_last_session'] = data.groupby('sessionId')['timestamp'].diff().dt.total_seconds()

# Calculate average time between interactions for each 'contentId'
average_time_between_interactions = data.groupby('contentId')['timestamp'].diff().dt.total_seconds().mean()
data['average_time_between_interactions'] = data['contentId'].map({content_id: average_time_between_interactions for content_id in data['contentId'].unique()})

# Calculate session duration for each 'personId' and 'sessionId'
data['session_duration'] = data.groupby(['personId', 'sessionId'])['timestamp'].diff().dt.total_seconds()

# Calculate average session duration per user ('personId')
average_session_duration_per_user = data.groupby('personId')['session_duration'].mean()
data['average_session_duration_user'] = data['personId'].map(average_session_duration_per_user)

# Define the features used for anomaly detection
features = ['time_since_last_event_user', 'time_since_last_event_content',
            'time_since_last_session', 'average_time_between_interactions',
            'session_duration', 'average_session_duration_user']

# Select the features for anomaly detection
X = data[features].fillna(data[features].mean())  # Fill missing values with mean

# Replace NaN values with None
X.replace({np.NaN: None}, inplace=True)

# Scale the features using StandardScaler
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# Train the One-Class SVM model for anomaly detection
model_svm = OneClassSVM(nu=0.05)
model_svm.fit(X_scaled)

# Train the Isolation Forest model for anomaly detection
model_isoforest = IsolationForest(contamination=0.05)
model_isoforest.fit(X_scaled)

# Train the K-Means clustering model for anomaly detection
model_kmeans = KMeans(n_clusters=2, random_state=42)
model_kmeans.fit(X_scaled)

def calculate_anomaly_counts(model, X_scaled):
    # Predict anomalies for the processed data using the specified model
    anomalies = model.predict(X_scaled)

    # Map anomaly predictions to labels
    if isinstance(model, (OneClassSVM, IsolationForest)):
        anomaly_labels = {1: 'Normal', -1: 'Abnormal'}
    else:
        anomaly_labels = {0: 'Normal', 1: 'Abnormal'}

    # Convert anomaly predictions to labels
    anomaly_labels = [anomaly_labels[prediction] for prediction in anomalies]

    # Count occurrences of 'Normal' and 'Abnormal'
    counts = pd.Series(anomaly_labels).value_counts().to_dict()

    return counts

@app.route('/processed_data/<model_name>', methods=['GET'])
def get_processed_data(model_name):
    if model_name == 'svm':
        model = model_svm
    elif model_name == 'isoforest':
        model = model_isoforest
    elif model_name == 'kmeans':
        model = model_kmeans
    else:
        return jsonify({'error': 'Invalid model name'}), 400

    anomaly_counts = calculate_anomaly_counts(model, X_scaled)

    return jsonify(anomaly_counts)

if __name__ == '__main__':
    app.run(debug=True, host='127.0.0.1', port=5000)
