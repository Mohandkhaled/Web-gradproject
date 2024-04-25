from flask import Flask, jsonify, request
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.svm import OneClassSVM
from sklearn.ensemble import IsolationForest
from sklearn.cluster import KMeans
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Apply CORS to your Flask app

# Load CSV data into a DataFrame (replace with your CSV path)
data_path = 'F:\\S\\Insiders\\gradproject\\data\\users_interactions.csv'  # Use double backslashes or raw string literal

try:
    data = pd.read_csv(data_path)
    print("CSV file loaded successfully.")
except Exception as e:
    print(f"Error loading CSV file: {e}")

# Define anomaly detection models and routes...

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
