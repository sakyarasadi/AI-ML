% Load Dataset
load fisheriris.mat;
 
% Random Generate
rng(1);
indices = randperm(size(meas, 1));
percentage = 0.6;
trainIndices = indices(1:round(percentage * size(meas, 1)));
testIndices = indices(round(percentage * size(meas, 1)) + 1:end);
 
% Create training and testing datasets
trainD = meas(trainIndices, :);
testD = meas(testIndices, :);
trainT = dummyvar(categorical(species(trainIndices)));
testT = dummyvar(categorical(species(testIndices)));
 
 
% Define Hidden Layers
hiddenLayers = [10, 15, 20];
 
% Select Feedforward Recognition Neural Networks
for layer = hiddenLayers
    fprintf('Size: %d\n', layer);
    
    for iteration = 1:3 % Repeat the the loop
        fprintf('Iteration: %d\n', iteration);
        
        % Create the feedforward neural network
        net = feedforwardnet(layer);
        net.layers{end}.size = 3; % Set the nodes
        
        % Train the neural network
        net.trainParam.showWindow = true; % Training Windows
        net = train(net, trainD', trainT');
        
        % View the trained network
        view(net);
 
        % Testing the network
        output = net(testD');
        % Index of maximum output
        [~, labels] = max(output);
        [~, actualLables] = max(testT');
        
        % Evaluate performance
        classification = sum(labels == actualLables);
        accuracy = classification / size(testT, 1) * 100;
        
        fprintf('Classifier Accuracy: %.2f%%\n\n', accuracy);
    end
end