import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.svm import OneClassSVM

def train_anomaly_detection_model(X):
    try:
        # Standardize the features
        scaler = StandardScaler()
        X_scaled = scaler.fit_transform(X)

        # Train One-Class SVM model
        model = OneClassSVM(nu=0.05)
        model.fit(X_scaled)

        # Obtain anomaly scores for the entire dataset
        anomaly_scores = model.decision_function(X_scaled)

        # Create anomaly labels based on threshold
        anomaly_labels = ['Abnormal' if score >= 0 else 'Normal' for score in anomaly_scores]

        # Add anomaly labels to the dataset
        X['anomaly_svm'] = anomaly_labels

        return model, X

    except Exception as e:
        print(f"Error in training anomaly detection model: {e}")
        return None, None
