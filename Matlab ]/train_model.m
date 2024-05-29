//This script uses the preprocessed data to train a machine learning model and evaluates its performance.
% train_model.m
% Split data into training and testing sets
cv = cvpartition(size(features, 1), 'HoldOut', 0.3);
idx = cv.test;
XTrain = features(~idx,:);
YTrain = labels(~idx,:);
XTest = features(idx,:);
YTest = labels(idx,:);

% Train a Decision Tree model
treeModel = fitctree(XTrain, YTrain);

% Validate the model on test data
YPred = predict(treeModel, XTest);
accuracy = sum(strcmp(YPred, YTest)) / numel(YTest);
disp(['Accuracy: ', num2str(accuracy)]);
