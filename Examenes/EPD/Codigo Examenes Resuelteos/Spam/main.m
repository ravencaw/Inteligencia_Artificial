%STEP 0: LOAD & PREPARE DATA
clear;
load("spamTest.mat");
load("spamTrain.mat");
Xtrain = X;
ytrain = y;
load("spamValidation.mat");
Xval = X;
yval = y;
warning("off");

%Parameters
[m n] = size(Xtrain);
%s = 3; %hidden layer size 
k = 1; %output layer size
max_hidden_layer_size = 10;
epsilon = 0.12;
accuracies = zeros(max_hidden_layer_size, 1);

% Calculate which number of hidden layer neurons is best
for s=1:max_hidden_layer_size
  initial_theta1 = randInitializeWeights(n+1, s, epsilon);
  initial_theta2 = randInitializeWeights(s+1, 1, epsilon);
  nn_params = [initial_theta1(:); initial_theta2(:)];
  %nn_params = zeros((n+1)*s+(s+1)*1, 1);
  %[J grad] = nnCostFunction (nn_params, n, s, X, y);
  options = optimset('MaxIter', 10);
  costFunction = @(p) nnCostFunction (p, n, s, Xtrain, ytrain);
  [grad J] = fmincg(costFunction, nn_params, options);

  theta1 = reshape(grad(1:(n+1)*s), s, n+1);
  theta2 = reshape(grad((n+1)*s+1:end), 1, s+1);
  
  accuracy = predict(theta1, theta2, Xval, yval);
  printf("Accuracy of prediction with %d hidden layer size: %f percent\n", s, accuracy*100); 
  accuracies(s) = accuracy;
end

% Predict with that number of hidden layer neurons
[bestAccuracy bestIndex] = max(accuracies);
printf("Best accuracy found with %d hidden layer size: %f percent\n", bestIndex, bestAccuracy); 

s = bestIndex;
initial_theta1 = randInitializeWeights(n+1, s, epsilon);
initial_theta2 = randInitializeWeights(s+1, 1, epsilon);
nn_params = [initial_theta1(:); initial_theta2(:)];
%nn_params = zeros((n+1)*s+(s+1)*1, 1);
%[J grad] = nnCostFunction (nn_params, n, s, X, y);
options = optimset('MaxIter', 5);
costFunction = @(p) nnCostFunction (p, n, s, Xtrain, ytrain);
[grad J] = fmincg(costFunction, nn_params, options);

theta1 = reshape(grad(1:(n+1)*s), s, n+1);
theta2 = reshape(grad((n+1)*s+1:end), 1, s+1);

accuracy = predict(theta1, theta2, Xtest, ytest);
printf("Accuracy of final prediction: %f percent\n", accuracy*100);