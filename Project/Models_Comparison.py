#Importing the libraries

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, LabelEncoder
from xgboost import XGBClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import precision_recall_curve, average_precision_score
from sklearn.preprocessing import label_binarize
from sklearn.multiclass import OneVsRestClassifier

# Importing the dataset

pokedex = pd.read_csv('Pokedex.csv')
X = pokedex.iloc[:, 8:17].values
y = pokedex.iloc[:, -1].values

label_encoder = LabelEncoder()
y = label_encoder.fit_transform(y)

# Splitting the dataset into the Training set and Test set

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

# Feature Scaling

sc = StandardScaler()
X_train = sc.fit_transform(X_train)
X_test = sc.transform(X_test)

# Creating the XGBoost Classifier

XGC = OneVsRestClassifier(XGBClassifier())
XGC.fit(X_train, y_train)

# Creating the Random Forest Classifier

RFC = OneVsRestClassifier(RandomForestClassifier(n_estimators = 63, criterion = 'gini', random_state = 0))
RFC.fit(X_train, y_train)

# Predicting the probabilities for Test set

y_pred_prob_RFC = RFC.predict_proba(X_test)
y_pred_prob_XGC = XGC.predict_proba(X_test)

# Compute precision-recall pairs for each class

precision_rfc = dict()
recall_rfc = dict()
average_precision_rfc = dict()
precision_xgc = dict()
recall_xgc = dict()
average_precision_xgc = dict()

for i in range(len(label_encoder.classes_)):
    precision_rfc[i], recall_rfc[i], _ = precision_recall_curve(label_binarize(y_test, classes = list(range(len(label_encoder.classes_)))).T[i], y_pred_prob_RFC[:, i])
    average_precision_rfc[i] = average_precision_score(label_binarize(y_test, classes = list(range(len(label_encoder.classes_)))).T[i], y_pred_prob_RFC[:, i])

    precision_xgc[i], recall_xgc[i], _ = precision_recall_curve(label_binarize(y_test, classes = list(range(len(label_encoder.classes_)))).T[i], y_pred_prob_XGC[:, i])
    average_precision_xgc[i] = average_precision_score(label_binarize(y_test, classes = list(range(len(label_encoder.classes_)))).T[i], y_pred_prob_XGC[:, i])

# Compute micro-average ROC Curve and ROC Area

precision_rfc["micro"], recall_rfc["micro"], _ = precision_recall_curve(label_binarize(y_test, classes=list(range(len(label_encoder.classes_)))).ravel(), y_pred_prob_RFC.ravel())
average_precision_rfc["micro"] = average_precision_score(label_binarize(y_test, classes = list(range(len(label_encoder.classes_)))).ravel(), y_pred_prob_RFC.ravel(), average="micro")

precision_xgc["micro"], recall_xgc["micro"], _ = precision_recall_curve(label_binarize(y_test, classes = list(range(len(label_encoder.classes_)))).ravel(), y_pred_prob_XGC.ravel())
average_precision_xgc["micro"] = average_precision_score(label_binarize(y_test, classes = list(range(len(label_encoder.classes_)))).ravel(), y_pred_prob_XGC.ravel(), average="micro")

# Plot Precision-Recall curves for each class

plt.figure(figsize=(10, 8))
colors = plt.cm.tab10(np.linspace(0, 1, len(label_encoder.classes_)))

for i, color in zip(range(len(label_encoder.classes_)), colors):
    plt.plot(recall_rfc[i], precision_rfc[i], color=color, lw=2,
             label=f'RFC Class {i} (AP = {average_precision_rfc[i]*100:0.2f})')
    plt.plot(recall_xgc[i], precision_xgc[i], color=color, linestyle='--', lw=2,
             label=f'XGC Class {i} (AP = {average_precision_xgc[i]*100:0.2f})')

plt.xlim([0.0, 1.0])
plt.ylim([0.0, 1.05])
plt.xlabel('Recall')
plt.ylabel('Precision')
plt.title('Precision-Recall Curve for Multi-Class Classification')
plt.legend(loc="best")
plt.grid(True)
plt.show()