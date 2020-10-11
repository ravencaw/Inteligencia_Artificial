%% Initialization
clear ; close all; clc

%% ======================= EJ1. Cargar y visualizar =======================

fprintf('Loading Data ...\n')

dataset = load('../datahw1.csv');

X = dataset(:,1:14);
y = dataset(:,15);

m = length(y);

x_size = size(X,2);

%%Ejercicio 1 %%
%% Calculo de la regresion univariable tomando el conjunto de datos como test
%% Calculamos regresion para cada columna

for i = 1:x_size

  %guardamos en una variable temporal la columna correspondiente a la iteracion  
  X_temp = X(:,i);
  %añadimos una columna de unos
  X_temp = [ones(m,1), X_temp];
  
  %calculo de theta
  theta = normalEqn(X_temp, y);
  
  %calulo del error para esa columna
  pre = X_temp * theta;

  error = absError(m, pre, y);
  error_list(:,i) = error;

endfor

error_list

%Ordenamos el vector de errores en orden ascendente

sorted_error_list=sort(error_list);
sorted_error_list