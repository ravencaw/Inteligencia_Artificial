%  Ejercicio: Linear regression with multiple variables

%% ================ Part 1: Normalizacion de atributos================

%% Clear and Close Figures
clear ; close all; clc

fprintf('Cargando datos ...\n');

%% Load Data 
rawdata = load("machinedata.txt");
X = rawdata(:,1:end-1);
y = rawdata(:,end);

% Print out some data points

fprintf('Primeras 10 instancias del conjunto de datos: \n');
fprintf(' x = [%.0f %.0f %.0f %.0f %.0f %.0f], y = %.0f \n', [X(1:10,:) y(1:10,:)]');

fprintf('Program paused. Press enter to continue.\n');
pause;

% Scale features and set them to zero mean
fprintf('Normalizando atributos ...\n');
[X, mu, sigma] = featureNormalize(X);

		
% Print out some data points
fprintf('Primeras 10 instancias del conjunto de datos: \n');
fprintf(' x = [%.0f %.0f %.0f %.0f %.0f %.0f], y = %.0f \n', [X(1:10,:) y(1:10,:)]');

fprintf('Program paused. Press enter to continue.\n');
pause;

% Add 1«s to X
X = [ones(size(X,1),1) X];

%% ================ Part 2: Partición para holdout ================



%Elegimos el porcentaje en el que dividimos training/test 
percent = 0.7;
[m n] = size(X);

fprintf('Calculando la partición training/test por Holdout ...\n');

Xtest = X(round(m*percent)+1:end,:);
ytest = y(round(m*percent)+1:end,:);

X = X(1:round(m*percent),:);
y = y(1:round(m*percent),:);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================ Part 3: Descenso del Gradiente ================



fprintf('Ejecutando descenso del gradiente ...\n');

% Choose some alpha value y número de iteraciones
alpha = 0.3;
iter = 1000;

% Init Theta and Run Gradient Descent 

theta = zeros (n,1);
J = computeCostMulti(X, y, theta);
fprintf("Initial J value for theta=0: %f \n", J);

[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, iter);


% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');

% Display gradient descent's result
fprintf('Theta calculado por descenso del gradiente: \n');
fprintf(' %f \n', theta);
fprintf('\n');
  
%% ================ Part 4: Predecir ================  

new_computer = [23, 16000, 32000, 64, 16, 32];
new_computer = (new_computer-mu)./sigma;
prediction = [1 new_computer]*theta;
fprintf('Prediccion: \n');
fprintf(' %f \n', prediction); 
pause;

%% ================ Part 5: Evaluar el aprendizaje ================
  

% Calcular el error cometido cuando predices el rendimiento del conjunto de
% ordenadores del conjunto de test X_test

pred_train = X*theta;
pred_test = Xtest*theta;

error_train = (100/m) * sum(abs(pred_train-y)./y);
error_test = (100/m) * sum(abs(pred_test-ytest)./ytest);


fprintf(['Error del conjunto de entrenamiento: %.2f\n'], error_train);
fprintf(['Error del conjunto de test: %.2f\n'], error_test);

thetanormeq = pinv(X)*y;
fprintf('Theta calculado por ecuacion normal: \n');
fprintf(' %f \n', thetanormeq);
fprintf('\n');
