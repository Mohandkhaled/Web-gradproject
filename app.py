from flask import Flask, render_template, request
import os
from preprocess import scale_features
from train_model import train_anomaly_detection_model

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload_file():
    if request.method == 'POST':
        file = request.files['file']
        if file:
            try:
                # Ensure the target directory exists
                directory_path = "F:/data2"
                if not os.path.exists(directory_path):
                    os.makedirs(directory_path)

                # Save uploaded file to the target directory
                file_path = os.path.join(directory_path, file.filename)
                file.save(file_path)

                # Preprocess data
                data = preprocess_data('F:/S/Insiders/gradproject/data/users_interactions.csv')

                if data is None:
                    return "Error: Data preprocessing failed"

                # Define features for scaling and modeling
                features = ['time_since_last_event_user', 'time_since_last_event_content',
                            'time_since_last_session', 'average_time_between_interactions',
                            'session_duration', 'average_session_duration_user']

                # Scale features
                data_scaled = scale_features(data, features)

                if data_scaled is None:
                    return "Error: Feature scaling failed"

                # Get X (input data for modeling)
                X = data_scaled[features]

                # Train anomaly detection model
                model_svm, cleaned_data = train_anomaly_detection_model(X)
              
                if model_svm is None:
                    return "Error: Model training failed"

                # Calculate F1 score
                true_labels = cleaned_data['anomaly_manual']
                predicted_labels_svm = (cleaned_data['anomaly_svm'] >= 0)
                f1_svm = calculate_f1_score(true_labels, predicted_labels_svm)

                # Render results page with F1 score
                return render_template('results.html', f1_svm=f1_svm)

            except Exception as e:
                return f"Error: {e}"

        else:
            return "Error: No file uploaded"

    return render_template('index.html')

def calculate_f1_score(true_labels, predicted_labels):
    from sklearn.metrics import f1_score
    return f1_score(true_labels, predicted_labels)

if __name__ == '__main__':
    app.run(debug=True)
