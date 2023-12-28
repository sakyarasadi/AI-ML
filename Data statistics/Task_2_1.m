% Load the data first
load fisheriris.mat

% Get the rows in the data
disp(['The number of rows: ', num2str(size(meas,1))])
% Initialize each feature inside an array
stats = zeros(4,5);

% Loop through each column
for i = 1:4
    % Get the column data
    x = meas(:,i);
    
    % Store the results in the stats array
    stats(i,:) = [mean(x), std(x), max(x), min(x), sqrt(mean(x.^2))];
end

% Columns
colnames = {'Sepal Length', 'Sepal Width', 'Petal Length', 'Petal Width'};

% Display Stats along with columns
for i = 1:4
    fprintf('%s:\n', colnames{i})
    fprintf('Mean: %.6f\n', stats(i,1))
    fprintf('Standard Deviation: %.6f\n', stats(i,2))
    fprintf('Maximum: %.6f\n', stats(i,3))
    fprintf('Minimum: %.6f\n', stats(i,4))
    fprintf('Root Mean Square: %.6f\n', stats(i,5))
    fprintf('\n')
end