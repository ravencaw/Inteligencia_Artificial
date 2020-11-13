%% HOMEWORK 3

%% Initialization
clear ; close all; clc

% Load Training Data
fprintf('Loading Data ...\n')

% Ejercicio 1 Carga y visualizacion
load('data.mat');

X_total = [X;Xval];
y_total = [y;yval];

%plotData(X_total, y_total);

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
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

% Weight regularization parameter (we set this to 0 here).
lambda = 0;

[J, grad] = nnCostFunction(initial_nn_params, input_layer_size, hidden_layer_size, ...
                   num_labels, X_total, y_total, lambda);
                   
fprintf(['Cost at parameters (loaded from ex4weights): %f \n(this value should be about 0.6947)\n'], J);

fprintf('Valor del descenso del gradiente\n');
grad

% Descenso del gradiente
options = optimset('GradObj', 'on','MaxIter', 150);

costFunction = (@(p)nnCostFunction(p, input_layer_size, hidden_layer_size, 
                                    num_labels, X_total, y_total, lambda));
                                    
% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)

[nn_params, cost] = fminunc(costFunction, initial_nn_params, options);                                    

% Obtain Theta1 and Theta2 back from nn_params

Theta1 = reshape(nn_params(1:(hidden_layer_size * (input_layer_size + 1))), ...
                hidden_layer_size, (input_layer_size+1));
                
anterior = hidden_layer_size * (input_layer_size + 1);
                
Theta2 = reshape(nn_params((anterior + 1): end), num_labels, (hidden_layer_size+1));

Theta1
Theta2

% Para terminar el Apartado 2 imprimimos la grafica con la frontera de decision
plot_decision_boundary(Theta1,Theta2, X_total, y_total);

