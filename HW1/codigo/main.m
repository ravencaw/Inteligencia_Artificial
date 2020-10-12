%% Initialization
clear ; close all; clc

%% ======================= EJ1. Cargar y visualizar =======================

fprintf('Loading Data ...\n')

dataset = load('../datahw1.csv');

X = dataset(:,1:14);
y = dataset(:,15);

X = featureNormalize(X);

m = length(y);

x_size = size(X,2);

%% EJERCICIO 1 %%
%% UNIVARIABLE
%% APARTADO A
%% Calculo de la regresion univariable tomando el conjunto de datos como test
%% Calculamos regresion para cada columna

for i = 1:x_size

  %guardamos en una variable temporal la columna correspondiente a la iteracion  
  X_temp = X(:,i);
  %anadimos una columna de unos
  X_temp = [ones(m,1), X_temp];
  
  %calculo de theta
  theta = normalEqn(X_temp, y);
  
  %calulo del error para esa columna
  pre = X_temp * theta;

  error = absError(m, pre, y);
  %guardamos el numero de la columna con su error correspondiente
  error_list(i,:) = [i,error];

endfor

%clear X_temp
clear X_temp;

%APARTADO B
%ordena la matriz en base a la segunda columna con los errores y guardamos los 5 mejores
best5 = sortrows(error_list, 2)(1:5,:);
%Imprime los 5 valores
best5

%repite con los 5 mejores valores
for i = 1:size(best5,1)
  
  %Limpiamos la variable temporal en cada iteracion
  clear X_temp;
  
  col = best5(i,1);
  X_temp = X(:,col);
  
  %anadimos una columna de unos
  X_temp = [ones(m,1), X_temp];
  
  %calculo de theta
  theta = normalEqn(X_temp, y);
  
  %calulo del error para esa columna
  pre = X_temp * theta;

  error = absError(m, pre, y);
  %guardamos el numero de la columna con su error correspondiente
  error_listBest5(i,:) = error;
  
endfor

%APARTADO E

%Separamos conjuntos de train y test por cada columna del ocnjunto de X
%asignamos el porcentaje de entrenamiento el resto sera test
percent = 0.7;

for i = 1:x_size
  
  %Limpiamos la variable temporal en cada iteracion
  clear X_temp;
  %guardamos en una variable temporal la columna correspondiente a la iteracion  
  X_temp = X(:,i);
  %realizamos la separacion en train y test
  [X_train,y_train, X_test, y_test] = holdout(X_temp, y, m, percent);
  
  m_train = length(y_train);
  m_test = length(y_test);
  
  %anadimos una columna de unos
  X_train = [ones(m_train,1), X_train];
  X_test = [ones(m_test,1), X_test];
  
  %calculo de theta
  theta = normalEqn(X_train, y_train);
  
  %calulo del error para esa columna
  pre = X_test * theta;

  error = absError(m_test, pre, y_test);
  %guardamos el numero de la columna con su error correspondiente
  error_listHoldout(i,:) = [i,error];

endfor


%imprime los mejores 5 resultados
best5Holdout = sortrows(error_listHoldout, 2)(1:5,:);

%repite con los 5 mejores valores
for i = 1:size(best5Holdout,1)
  
  %Limpiamos la variable temporal en cada iteracion
  clear X_temp;
  
  col = best5Holdout(i,1);
  X_temp = X(:,col);
  
  %realizamos la separacion en train y test
  [X_train,y_train, X_test, y_test] = holdout(X_temp, y, m, percent);
  
  m_train = length(y_train);
  m_test = length(y_test);
  
  %anadimos una columna de unos
  X_train = [ones(m_train,1), X_train];
  X_test = [ones(m_test,1), X_test];
  
  %calculo de theta
  theta = normalEqn(X_train, y_train);
  
  %calulo del error para esa columna
  pre = X_test * theta;

  error = absError(m_test, pre, y_test);
  %guardamos el numero de la columna con su error correspondiente
  error_listBest5holdout(i,:) = error;
  
endfor


%%%------------------------------------------------------------------------------------
%%EJERCICIO 1
%%MULTIVARIABLE%%
%Apartado A

%anadimos una columna de unos
  X = [ones(m,1), X];
  
  %calculo de theta
  theta = normalEqn(X, y);
  
  %calulo del error para esa columna
  pre = X * theta;

  error = absError(m, pre, y);
  
%%APARTADO E

%% volvemos a guardar el conjunto original
X = dataset(:,1:14);

%realizamos la separacion en train y test
[X_train,y_train, X_test, y_test] = holdout(X, y, m, percent);
  
  m_train = length(y_train);
  m_test = length(y_test);
  
  %anadimos una columna de unos
  X_train = [ones(m_train,1), X_train];
  X_test = [ones(m_test,1), X_test];
  
  %calculo de theta
  theta = normalEqn(X_train, y_train);
  
  %calulo del error para esa columna
  pre = X_test * theta;

  errorHoldout = absError(m_test, pre, y_test);
  
  
  
  
##%%APARTADO B
##%imprime los mejores 5 resultados
##best5 = sortrows(error_list, 2)(1:5,:);
##%Imprime los 5 valores
##best5
##
##%%APARTADO C
##%%Repetimos usando los 5 mejores resultados
##%%Guardamos las mejores 5 columnas
##col = best5(1,1);
##X_temp = X(:,col);
##
##for i = 2:size(best5,1)
##    
##  col = best5(i,1);
##  X_temp = [X_temp, X(:,col)];
##
##endfor
##
##
##%calculo de theta
##  theta = normalEqn(X_temp, y);
##  
##  %calulo del error para esa columna
##  pre = X_temp * theta;
##
##  error = absError(m, pre, y);
  
  
  
  
  
  