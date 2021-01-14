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

%% Setup the parameters you will use for this exercise
input_layer_size  =   % features for each image
hidden_layer_size =    % hidden units

%% =========== Part 1: Loading Data =============
%  We start the exercise by first loading the dataset. 


% Load Training Data
fprintf('Loading Training Data ...\n')



% Load Test Data
fprintf('Loading Test Data ...\n')



fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================ Part 2: Initializing Parameters ================
%  In this part of the exercise, you will be starting to implment a two
%  layer neural network that classifies images. You will start by
%  initializing the weights of the neural network

fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 =
initial_Theta2 =

% Unroll parameters initial_Theta1 and initial_Theta2
initial_nn_params =



%% =================== Part 3: Training NN ===================
%  To train your neural network, we will now use "fmincg", which
%  is a function which works similarly to "fminunc". Recall that these
%  advanced optimizers are able to train our cost functions efficiently as
%  long as we provide them with the gradient computations.
%
fprintf('\nTraining Neural Network... \n')

%  Initialization of the parameter MaxIter using function optimset
options =


% Create "short hand" for the cost function to be minimized
costFunction = @(p) 

% Obtain parameters of the neural networks calling an advanced optimization function
[nn_params, cost] =


% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 1, (hidden_layer_size + 1));

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================= Part 4: Implement Predict =================
%  After training the neural network, we would like to use it to predict
%  the labels for training set and for test set.

pred_train =
pred_test =

fprintf('\nTraining Set Accuracy: %f\n', );
fprintf('\nTest Set Accuracy: %f\n', );

