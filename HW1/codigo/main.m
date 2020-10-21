%% Initialization
clear ; close all; clc

%% ======================= EJ1. Cargar y visualizar =======================

fprintf('Loading Data ...\n')

dataset = load('../datahw1.csv');

X = dataset(:,1:14);
y = dataset(:,15);

##X = featureNormalize(X);

m = length(y);

x_size = size(X,2);

%% EJERCICIO 1 %%
fprintf "--------------------------------\nEJERCICIO 1\n--------------------------------\n"
fprintf "APARTADO A\n"
%% Calculo de la regresion univariable tomando el conjunto de datos como test
%% Apartado A
%% Regresion multivariable de todo el conjunto
%anadimos una columna de unos
X_temp = [ones(m,1), X];
  
%calculo de theta
theta = normalEqn(X_temp, y)
  
%calulo del error para esa columna
pre = X_temp * theta;

fprintf "Error todo el conjunto\n"
error = absError(m, pre, y)

%%--------------------------------------------------------------------------------

%%Apartado B
%% Regresion univariable por cada columna
fprintf "\nAPARTADO B\n"
%Guardamos la mejor theta
bestTheta = 0;
fprintf "Thetas calculadas\n"
for i = 1:x_size

  %guardamos en una variable temporal la columna correspondiente a la iteracion  
  X_temp = X(:,i);
  %anadimos una columna de unos
  X_temp = [ones(m,1), X_temp];
  
  %calculo de theta
  theta = normalEqn(X_temp, y)
  
   if(i == 1)
    bestTheta = theta;
  endif
  
  %calulo del error para esa columna
  pre = X_temp * theta;

  error = absError(m, pre, y);
  %guardamos el numero de la columna con su error correspondiente
  error_list(i,:) = [i,error];

endfor

%%--------------------------------------------------------------------------------

%%Apartado C
%% Regresion multivariable con los 5 mejores

%clear X_temp
clear X_temp;

fprintf "APARTADO C\n"
fprintf "Lista de errores\n"
error_list
%ordena la matriz en base a la segunda columna con los errores y guardamos los 5 mejores
best5 = sortrows(error_list, 2)(1:5,:);
%Imprime los 5 valores
fprintf "Mejores 5\n"
best5

%repite con los 5 mejores valores
%guarda los 5 mejores en un conjunto nuevo
for i = 1:size(best5,1)
  
  %Limpiamos la variable temporal en cada iteracion
  clear X_temp;
  
  col = best5(i,1);
  X_temp = X(:,col);
  
endfor

%% Aplicamos la regresion

%anadimos una columna de unos
X_temp = [ones(m,1), X_temp];
  
%calculo de theta
fprintf "Thetas 5 mejores\n"
theta = normalEqn(X_temp, y)
  
%calulo del error para esa columna
pre = X_temp * theta;

fprintf "Error 5 mejores\n"
error = absError(m, pre, y)

%%--------------------------------------------------------------------------------

%%Apartado E
fprintf "\nAPARTADO E\n"
%%Separamos el conjunto en un 70/30 y repetimos lo anterior
%porcentaje de training
percent = 0.7;

%%separacion del conjunto
[X_train,y_train, X_test, y_test] = holdout(X, y, m, percent);

m_train = length(y_train);
m_test = length(y_test);

%%Repeticion apartado A
%%Aplicamos regresion multivariable a todo el conjunto

%anadimos una columna de unos
X_train = [ones(m_train,1), X_train];
X_test = [ones(m_test,1), X_test];

%calculo de theta
theta = normalEqn(X_train, y_train)
  
%calulo del error para esa columna
pre = X_test * theta;

fprintf "Error todo el conjunto\n"
error = absError(m_test, pre, y_test)

%%Repeticion apartado B
%%Aplicar regresion univariable por cada columna
fprintf "Thetas calculadas\n"

for i = 2:x_size

  %guardamos en una variable temporal la columna correspondiente a la iteracion  
  X_temp = X_train(:,i);
  %anadimos una columna de unos
  X_temp = [ones(m_train,1), X_temp];
  
  %calculo de theta
  theta = normalEqn(X_temp, y_train)
 
  %añadimos colmuna de unos al conjunto de test
  X_test_aux = [ones(m_test,1), X_test(:,i)];
  %calulo del error para esa columna
  pre = X_test_aux * theta;

  error = absError(m_test, pre, y_test);
  %guardamos el numero de la columna con su error correspondiente
  error_list(i,:) = [i,error];

endfor

%%Repeticion apartado C
%%Guardamos 5 mejores y aplicamos regresion multivariable

%clear X_temp
clear X_temp;

fprintf "Lista de errores\n"
error_list
%ordena la matriz en base a la segunda columna con los errores y guardamos los 5 mejores
best5split = sortrows(error_list, 2)(2:6,:);
%Imprime los 5 valores
fprintf "Mejores 5\n"
best5split
%anadimos una columna de unos
X_trainBest = [ones(m_train,1)];
X_testBest = [ones(m_test,1)];

%guarda los 5 mejores en un conjunto nuevo

for i = 2:size(best5split,1)
  
  col = best5split(i,1);
  X_trainBest = horzcat(X_trainBest,X_train(:,col));
  X_testBest = horzcat(X_testBest,X_test(:,col));
  
endfor

%% Aplicamos la regresion
  
%calculo de theta
fprintf "Thetas 5 mejores\n"
theta = normalEqn(X_trainBest, y_train)
  
%calulo del error para esa columna
pre = X_testBest * theta;

fprintf "Error 5 mejores\n"
error = absError(m_test, pre, y_test)

%%-------------------------------------------------------
%%EJERCICIO 2 DESCENSO DEL GRADIENTE
%%-------------------------------------------------------
fprintf "--------------------------------\nEJERCICIO 2\n--------------------------------\n"
%%Descenso con todo el conjunto de datos
X_train(:,1) = [];

%%Normalizamos los datos
X_train = featureNormalize(X_train);
y_train = featureNormalize(y_train);

X_train = [ones(m_train,1), X_train];

%%Inicializamos alpha y num iteraciones
alpha = 0.03;
iterations = 200;

%inicializamos theta con ceros al tamano de X_train
theta_grad = zeros(size(X_train, 2), 1);

%Aplica descenso del gradiente
[theta, J_history] = gradientDescent(X_train, y_train, theta_grad, alpha, iterations);

fprintf "Thetas calculadas con descenso de gradiente con conjunto completo\n" 
theta
%pintamos la grafica de convergencia
%graficaConvergencia(J_history);

%hallamos la prediccion en base al modelo
pre = X_test * theta;

%hallamos el error de la prediccion
error = absError(m_test, pre, y_test)


%%--------------------------------------------------------------------------------
%%Descenso con los 5 mejores

X_trainBest(:,1) = [];

%%Normalizamos los datos
X_trainBest = featureNormalize(X_trainBest);

%volvemos a añadir la columna de unos
X_trainBest = [ones(m_train,1), X_trainBest];

%%Inicializamos alpha y num iteraciones
alpha = 0.3;
iterations = 200;

%inicializamos theta con ceros al tamaï¿½o de X_train
theta_grad = zeros(size(X_trainBest, 2), 1);

%Aplica descenso del gradiente
[theta, J_historyBest5] = gradientDescent(X_trainBest, y_train, theta_grad, alpha, iterations);

fprintf "Theta calculada con descenso de gradiente con conjunto 5 mejores\n" 
theta

%pintamos la grafica de convergencia
%graficaConvergencia(J_historyBest5);

%hallamos la prediccion en base al modelo
pre = X_testBest * theta;

%hallamos el error de la prediccion
error = absError(m_test, pre, y_test)

%%-------------------------------------------------------
%%EJERCICIO 3 VISUALIZACION DE DATOS
%%-------------------------------------------------------

%obtenemos el valor de la fila con el mejor valor del EJ1-A
bestRow = best5(1,1);
%obtenemos la mejor columna del conjunto de datos
best = X(:,bestRow);

visualizarDatos(best, bestTheta, J_history, J_historyBest5, y) 




  
  
  