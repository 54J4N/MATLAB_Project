//This script will handle downloading and preprocessing your dataset. It prepares the features and labels necessary for the machine learning model.
% data_preprocessing.m
% Load an example dataset
gunzip('kddcup.data_10_percent.gz');  % Decompress the file
data = readtable('kddcup.data_10_percent', 'ReadVariableNames', false);  % Read the data into MATLAB

% Assuming the last column is the class label and rest are features
features = data(:,1:end-1);
labels = data(:,end);

% Convert categorical features to numeric using dummy encoding
features = varfun(@categorical, features, 'OutputFormat', 'table');
for i = 1:size(features, 2)
    dummyVars = dummyvar(features.(i));
    features.(i) = mat2cell(dummyVars, size(dummyVars, 1), ones(1, size(dummyVars, 2)));
end
features = table2array(features);

% Normalize features (example using z-score normalization)
for i = 1:size(features, 2)
    if isnumeric(features(:,i))
        features(:,i) = (features(:,i) - mean(features(:,i))) / std(features(:,i));
    end
end
