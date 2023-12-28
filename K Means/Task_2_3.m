% Load the dataset
load kmeansdata.mat; 

% Define Clusters
clusters = [3, 4, 5];

% Best Silhouette and the optimal K
bestSilhoue = -Inf;
optimalK = 0;

% Loop cluster numbers
for k = clusters
    
    % K-means clustering
    [idx, C] = kmeans(X, k); 
    scores = silhouette(X, idx);
    meanSilh = mean(scores);
    
    % Silhouette score for K
    disp(['Mean Silhouette score for K = ' num2str(k) ': ' num2str(meanSilh)]);
    
    % Update the best Silhouette score and the optimal K
    if meanSilh > bestSilhoue
        bestSilhoue = meanSilh;
        optimalK = k;
        best_idx = idx;
        best_C = C;
    end
end

% Display the optimal number of clusters
disp(['The optimal number of clusters is ' num2str(optimalK) ' based on Silhouette score']);

% Plot Silhouette for the optimal K
figure;
silhouette(X, best_idx);
title(['Silhouette Plot for K = ' num2str(optimalK)]);

% Plot clusters and centroids for the optimal K
figure;
gscatter(X(:, 1), X(:, 2), best_idx);
hold on;
plot(best_C(:, 1), best_C(:, 2), 'kx', 'MarkerSize', 13, 'LineWidth', 3);
title(['Cluster Assignments and Centroids for K = ' num2str(optimalK)]);
legend_entries = cellstr(num2str((1:optimalK)', 'Cluster %d'));
legend(legend_entries, 'Location', 'NW');
hold off;
