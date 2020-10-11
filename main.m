%% Initialization
clear ; close all; clc

%% ======================= EJ1. Cargar y visualizar =======================

fprintf('Loading Data ...\n')

dataset = load('../datahw1.csv');

X = dataset(:,1:14);
y = dataset(:,15);

m = length(y);

%%Ejercicio 1 %%
%% Calculo de la regresion univariable tomando el conjunto de datos como test
%% Calculamos regresion para cada columna

% Primer atributo densidad de pesaje bajo agua
X_densidad = X(:,1);

%añadimos columna de 1
X_densidad = [ones(m,1), X_densidad];

theta = normalEqn(X_densidad, y);

%Calculamos el error_densidad

pre = X_densidad * theta;

error_densidad = absError(m, pre, y)



