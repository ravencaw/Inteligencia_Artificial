  
%% Initialization
 clear ; close all; clc

%% ======================= HOMEWORK 2 =======================
%% Cargar datos
fprintf('Loading Data ...\n')
data = load('dataset_2.csv');
X = data(:,2:3);
y = data(:,1);

%%Ejercicio 1
%plotData(X, y);

%%---------------------------------------------

%%Ejercicio 2
% tamaño del conjunto
[m, n] = size(X);

%% añadimos una columna de unos a la X
X =  [ones(m,1), X];

%%Inicializamos la theta a 0
theta_ini = zeros(n+1, 1);

%%calculo del coste inicial
[coste_ini, grad] = costFunction(X, y, theta_ini);

fprintf('Funcion de coste: \n')
fprintf('Cost at initial theta (zeros): %f\n', coste_ini)
fprintf('Gradient at initial theta (zeros): \n') 
fprintf(' %f \n', grad)

%%descenso del gradiente
%%inicializamos los parametros
alpha = 1;
iterations = 10;

fprintf('Funcion de descenso del gradiente para iterations=%d y alpha=%d \n', iterations, alpha)
[theta, J_history] = gradientDescent(X, y, theta_ini, alpha, iterations);

%imprimir la tasa de acierto y la grafica con la frontera de decisión
plotDecisionBoundary(theta, X, y);

%imprimir la tasa de acierto y la grafica con la frontera de decisión
%prediccion
p = predict(theta',X');
%tasa de acierto del modelo
percent = mean((p==y))*100;
%imprimimos tasa de acierto 
fprintf('La tasa de acierto: %d\n', percent(1));

