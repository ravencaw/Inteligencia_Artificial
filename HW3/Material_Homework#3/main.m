%% HOMEWORK 3

%% Initialization
clear ; close all; clc

% Load Training Data
fprintf('Loading Data ...\n')

% Ejercicio 1 Carga y visualizacion
load('data.mat');

plotData(X, y);

% Ejercicio 2 
%% Setup the parameters you will use for this exercise
input_layer_size  = 2;  % 20x20 Input Images of Digits
hidden_layer_size = 2;   % 25 hidden units
num_labels = 1;          % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)


initial_Theta1=[0.0837, -0.0081, 0.0312;
                -0.1078, -0.0418, -0.0647];

initial_Theta2=[0.0192, 0.0248, 0.0240];

% Unroll parameters 
nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

% Weight regularization parameter (we set this to 0 here).
lambda = 0;

J = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, ...
                   num_labels, X, y, lambda);
                   
fprintf(['Cost at parameters (loaded from ex4weights): %f \n(this value should be about 0.6947)\n'], J);