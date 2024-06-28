# Importing the libraries

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
from sklearn.metrics import confusion_matrix
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import GridSearchCV
from sklearn.inspection import permutation_importance

# Importing the dataset

pokedex = pd.read_csv('Pokedex.csv')
X = pokedex.iloc[:, 8:17].values
y = pokedex.iloc[:, -1].values

label_encoder = LabelEncoder()
y = label_encoder.fit_transform(y)

# Splitting the dataset into the Training set and Test set

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)

# Feature Scaling

sc = StandardScaler()
X_train = sc.fit_transform(X_train)
X_test = sc.transform(X_test)

# Creating the Random Forest Classifier

RFC = RandomForestClassifier(n_estimators = 63, criterion = 'gini', random_state = 0)
RFC.fit(X_train, y_train)

# Predicting the Test set results

y_pred_RFC = RFC.predict(X_test)

# Calculating the accuracy score

accuracy = accuracy_score(y_test, y_pred_RFC)
print(f"Accuracy: {accuracy*100: .2f}%")

# Making the Confusion Matrix

cm = confusion_matrix(y_test, y_pred_RFC)
print(cm)

# Applying k-fold cross validation

accuracies = cross_val_score(estimator = RFC, X = X_train, y = y_train, cv = 10)
print(f"Average Accuracy: {accuracies.mean()*100: .2f}%")
print(f"Standard Deviation of Accuracy: {accuracies.std()*100: .2f}%")

# Applying Grid Search

parameters = [{'n_estimators': range(1, 200), 'criterion': ['entropy']},
              {'n_estimators': range(1, 200), 'criterion': ['gini']}]
grid_search = GridSearchCV(estimator = RFC,
                           param_grid = parameters,
                           scoring = 'accuracy',
                           cv = 10,
                           n_jobs = -1)
grid_search = grid_search.fit(X_train, y_train)
best_accuracy = grid_search.best_score_
best_parameters = grid_search.best_params_
print(f"Best Accuracy: {best_accuracy*100: .2f}%")
print(f"Best Values for Parameters: {best_parameters}")

# Analyzing variable importance

result = permutation_importance(RFC, X_test, y_test, n_repeats = 10,
                                random_state = 0, n_jobs = -1)
importance_df = pd.DataFrame({'Feature': pokedex.columns[8:17], 'MeanDecreaseAccuracy': result.importances_mean,
                              'MeanDecreaseGini': RFC.feature_importances_})
print(importance_df)