import matplotlib.pyplot as plt
import seaborn as sns

def plot_pie_chart(labels, sizes, title):
    plt.figure(figsize=(8, 8))
    colors = ['lightblue', 'salmon']
    explode = (0, 0.1)
    plt.pie(sizes, labels=labels, autopct='%1.1f%%', colors=colors, explode=explode, startangle=140)
    plt.title(title)
    plt.show()

def plot_confusion_matrix(matrix, title):
    plt.figure(figsize=(8, 6))
    sns.heatmap(matrix, annot=True, fmt='d', cmap='Blues', cbar=False,
                xticklabels=['Abnormal', 'Normal'], yticklabels=['Abnormal', 'Normal'])
    plt.xlabel('Predicted')
    plt.ylabel('True')
    plt.title(title)
    plt.show()
