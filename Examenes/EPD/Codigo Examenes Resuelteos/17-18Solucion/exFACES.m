%% Machine Learning Online Class - Exercise 4 Neural Network Learning

%  Descripción
%  ------------
% 
%  Este fichero contiene el programa principal de una red neuronal 
%  para clasificar emails en SPAM/NO SPAM. Se implementa la red neuronal
%  como un problema de clasificación multietiqueta con dos etiquetas.
%  El número óptimo de neuronas de la capa oculta es un parámetro de entrada.
%

%% Initialization
clear ; close all; clc

%% Setup the parameters you will use for this exercise
input_layer_size  = 960;  % 960 features for each email
hidden_layer_size = 4;   % 4 hidden units

%% =========== Part 1: Loading Data =============
%  We start the exercise by first loading the dataset. 
%  You will be working with a dataset that contains emails.

% Load Training Data
fprintf('Loading Data ...\n')

load('faces_lr.data');
Xtrain = faces_lr(:,1:960);
ytrain = faces_lr(:,961);


load('faces_lr.test');
Xtest = faces_lr(:,1:960);
ytest = faces_lr(:,961);

Xtrain=[Xtrain;Xtest(1:90,:)];
ytrain=[ytrain;ytest(1:90,:)];
m = size(Xtrain, 1);

Xtest = Xtest(91:end,:);
ytest = ytest(91:end,:);



fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================ Part 2: Initializing Parameters ================
%  In this part of the exercise, you will be starting to implment a two
%  layer neural network that classifies emails. You will start by
%  implementing a function to initialize the weights of the neural network
%  (randInitializeWeights.m)

fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, 1);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];



%% =================== Part 3: Training NN ===================
%  You have now implemented all the code necessary to train a neural 
%  network. To train your neural network, we will now use "fmincg", which
%  is a function which works similarly to "fminunc". Recall that these
%  advanced optimizers are able to train our cost functions efficiently as
%  long as we provide them with the gradient computations.
%
fprintf('\nTraining Neural Network... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter', 50);


% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   Xtrain, ytrain);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 1, (hidden_layer_size + 1));

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================= Part 4: Implement Predict =================
%  After training the neural network, we would like to use it to predict
%  the labels. You will now implement the "predict" function to use the
%  neural network to predict the labels of the test set. This lets
%  you compute the test set accuracy.

load('faces_lr.test');
Xtest = faces_lr(:,1:960);
ytest = faces_lr(:,961);

pred_train = predict(Theta1, Theta2, Xtrain);
pred_test = predict(Theta1, Theta2, Xtest);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred_train == ytrain)) * 100);
fprintf('\nTest Set Accuracy: %f\n', mean(double(pred_test == ytest)) * 100);

