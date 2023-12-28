%load fisheriris dataset
load fisheriris.mat

rng(0);

%create a random holdout partition
cv = cvpartition(size(meas,1),'HoldOut',0.4);
idx = cv.test;

%split the dataset into 60% training and 40% testing 

%training
data_training = meas(~idx,:);
Training_Data=data_training(:,1:end-1);
Class_Label_Training_target=data_training(:,end);
Class_Label_Training_target = species(~idx);

%testing
data_testing = meas(idx,:);
Testing_Data=data_testing(:,1:end-1);
Class_Label_Testing_target=data_testing(:,end);
Class_Label_Testing_target = species(idx);

%Evaluate different K values
k_values=[5,7];
correct_classification_percentage = [];

for K=k_values

%training the model
     modelformed=fitcknn(Training_Data,Class_Label_Training_target, 'NumNeighbors',K);

%Accuracy with default model parameters
     mk=predict(modelformed,Testing_Data);

%display confusion matrix
     confusion_matrix=confusionmat(Class_Label_Testing_target,mk);

%display percentage of correct classifications
    correct_classification_rate = sum(diag(confusion_matrix));
    total_samples = sum(confusion_matrix(:));
    accuracy_check = (correct_classification_rate / total_samples) * 100;

%Display results for the current K value
    fprintf('K = %d\n', K);
    disp('Confusion Matrix:');
    disp(confusion_matrix);
    fprintf('Correct Classification presentage: %.2f%%\n', accuracy_check);

end