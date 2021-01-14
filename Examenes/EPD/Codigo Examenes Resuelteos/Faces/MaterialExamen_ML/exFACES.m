%% Machine Learning  - Exercise Neural Networks 

%  Descripción
%  ------------
%  Este fichero contiene el programa principal de una red neuronal 
%  para reconocimiento facial. Se implementa la red neuronal
%  como un problema de clasificación binaria con etiquetas 0/1.
%  El número de neuronas de la capa oculta es un parámetro de entrada.
%

%% Initialization
clear ; close all; clc
warning("off");
%% Setup the parameters you will use for this exercise
input_layer_size  = 960;  % features for each image
hidden_layer_size = 4;  % hidden units

%% =========== Part 1: Loading Data =============
%  We start the exercise by first loading the dataset. 

% Load Training Data
fprintf('Loading Training Data ...\n')
rawdata_train = load("faces_lr.data");

% Load Test Data
fprintf('Loading Test Data ...\n')
rawdata_test = load("faces_lr.test");

rawdata = [rawdata_train; rawdata_test];
m = size(rawdata,1);
X = rawdata(1:round(m*0.7),1:end-1);
y = rawdata(1:round(m*0.7),end);
Xtest = rawdata(round(m*0.7)+1:end,1:end-1);
ytest = rawdata(round(m*0.7)+1:end,end);
LAMBDA = 850;
fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================ Part 2: Initializing Parameters ================
%  In this part of the exercise, you will be starting to implment a one
%  layer neural network that classifies images. You will start by
%  initializing the weights of the neural network

fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights (input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights (hidden_layer_size, 1);

% Unroll parameters initial_Theta1 and initial_Theta2
initial_nn_params = [initial_Theta1(:); initial_Theta2(:)];



%% =================== Part 3: Training NN ===================
%  To train your neural network, we will now use "fmincg", which
%  is a function which works similarly to "fminunc". Recall that these
%  advanced optimizers are able to train our cost functions efficiently as
%  long as we provide them with the gradient computations.
%
fprintf('\nTraining Neural Network... \n')

%  Initialization of the parameter MaxIter using function optimset
options = optimset("MaxIter", 300);


% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, input_layer_size, hidden_layer_size, X, y, LAMBDA);

% Obtain parameters of the neural networks calling an advanced optimization function
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);


% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 1, (hidden_layer_size + 1));

plot(cost);                 
                 
fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================= Part 4: Implement Predict =================
%  After training the neural network, we would like to use it to predict
%  the labels for training set and for test set.

pred_train = predict(Theta1, Theta2, X);
pred_test = predict(Theta1, Theta2, Xtest);

accuracy_train = mean(double(y==pred_train));
accuracy_test = mean(double(ytest==pred_test));


fprintf('\nTraining Set Accuracy: %f\n', accuracy_train*100);
fprintf('\nTest Set Accuracy: %f\n', accuracy_test*100);

