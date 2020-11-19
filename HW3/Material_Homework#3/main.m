%% HOMEWORK 3

%% Initialization
clear ; close all; clc

% Load Training Data
fprintf('Loading Data ...\n')

% Ejercicio 1 Carga y visualizacion
fprintf('Ejercicio 1, imprimiendo grafica\n')

load('data.mat');

X_total = [X;Xval];
y_total = [y;yval];

%figure;
plotData(X_total, y_total);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio 2 
%% Setup the parameters you will use for this exercise
input_layer_size  = 2;  % 20x20 Input Images of Digits
hidden_layer_size = 2;   % 25 hidden units
num_labels = 1;          % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)
                          
fprintf('Ejercicio 2\n')


%thetas iniciales para probar
initial_Theta1=[0.0837, -0.0081, 0.0312;
              -0.1078, -0.0418, -0.0647];

initial_Theta2=[0.0192, 0.0248, 0.0240];

%Generamos las thetas aleatoriamente
%initial_Theta1 = randInitializeWeights(input_layer_size,hidden_layer_size);
%initial_Theta2 = randInitializeWeights(hidden_layer_size,num_labels);

% Unroll parameters 
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

[J, grad] = nnCostFunction(initial_nn_params, input_layer_size, hidden_layer_size, ...
                   num_labels, X_total, y_total);
                   
fprintf(['Cost at parameters (loaded from ex4weights): %f \n(this value should be about 0.6947)\n'], J);

fprintf('Valor del descenso del gradiente\n');
round(grad .* 10000) ./ 10000

% Descenso del gradiente
options = optimset('GradObj', 'on','MaxIter', 150);

costFunction = (@(p)nnCostFunction(p, input_layer_size, hidden_layer_size, 
                                    num_labels, X_total, y_total));
                                    
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
%plot_decision_boundary(Theta1,Theta2, X_total, y_total);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Ejercicio 3
%experimentamos con diferentes numero de neuronas en la capa oculta
fprintf('Ejercicio 3\n')

%Guardamos en un array los tama�os de la capa a probar para iterar sobre ellos
hidden_layer_sizes= [1,2,3,4,5,10];

for i=1:length(hidden_layer_sizes)
  
  printf("Comienzo de la iteracion\n");
  
  % Obtenemos el tama�o de la iteracion actual
  hidden_layer_size=hidden_layer_sizes(i);
  
  %Generamos las thetas aleatoriamente
  initial_Theta1 = randInitializeWeights(input_layer_size,hidden_layer_size);
  initial_Theta2 = randInitializeWeights(hidden_layer_size,num_labels);
  
  % Unroll parameters
  initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];
  
  % Descenso del gradiente
  options = optimset('GradObj', 'on','MaxIter', 150);

  costFunction = (@(p)nnCostFunction(p, input_layer_size, hidden_layer_size, 
                                    num_labels, X_total, y_total));
                                    
  % Now, costFunction is a function that takes in only one argument (the
  % neural network parameters)

  [nn_params, cost] = fminunc(costFunction, initial_nn_params, options);  

  % Obtain Theta1 and Theta2 back from nn_params

  Theta1 = reshape(nn_params(1:(hidden_layer_size * (input_layer_size + 1))), ...
                hidden_layer_size, (input_layer_size+1));
                
  anterior = hidden_layer_size * (input_layer_size + 1);
                
  Theta2 = reshape(nn_params((anterior + 1): end), num_labels, (hidden_layer_size+1));
  
  %imprime las thetas
  printf("Thetas tras la optimizacion para %d neuronas.\n", hidden_layer_size);
  Theta1
  printf("\n");
  Theta2
  printf("\n");

  
  %Imprime los resultados
  %plot_decision_boundary(Theta1, Theta2, X, y);

  p = predict(Theta1, Theta2, X);

  fprintf('Exactitud con %d neuronas: %f\n', hidden_layer_size, mean(double(p==y)*100));
  
  printf("Fin de la iteracion\n");
  
endfor

printf("Fin del bucle\n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Ejercicio 4
%% Setup the parameters you will use for this exercise
input_layer_size  = 2;  
hidden_layer_size = 3; %3 neuronas para probar 10 neuronas para el ejercicio  
num_labels = 1;

%Generamos las thetas aleatoriamente
initial_Theta1 = randInitializeWeights(input_layer_size,hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size,num_labels);

%thetas iniciales para probar con 3 neuronas
%initial_Theta1=[-0.069081, -0.077998, 0.094653;
 %               -0.096356, -0.080743, 0.003974;
 %               0.077658, 0.039837, 0.048649];

%initial_Theta2=[-0.083138, 0.10883, 0.0098122, 0.043136];

% Unroll parameters 
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

% Weight regularization parameter (we set this to 0 here).
lambda = 0.03;

%apply regularization
[J, grad] = nnCostFunctionReg(initial_nn_params, input_layer_size, hidden_layer_size, ...
                   num_labels, X_total, y_total, lambda);

fprintf(['Cost at parameters (loaded from ex4weights): %f \n(this value should be about 0.6926)\n'], J);

fprintf('Valor del descenso del gradiente\n');
round(grad .* 100000) ./ 1000000

% Descenso del gradiente
%100o iteraciones para probar con las thetas de prueba
options = optimset('GradObj', 'on','MaxIter', 1000);

costFunction = (@(p)nnCostFunction(p, input_layer_size, hidden_layer_size, 
                                    num_labels, X_total, y_total));
                                    
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

p = predict(Theta1, Theta2, X);

printf('Exactitud con %d neuronas: %f\n', hidden_layer_size, mean(double(p==y)*100));