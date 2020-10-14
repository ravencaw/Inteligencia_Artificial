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
%% UNIVARIABLE
fprintf "APARTADO A\n"
%% Calculo de la regresion univariable tomando el conjunto de datos como test
%% Calculamos regresion para cada columna

fprintf "Thetas calculadas\n"
for i = 1:x_size

  %guardamos en una variable temporal la columna correspondiente a la iteracion  
  X_temp = X(:,i);
  %anadimos una columna de unos
  X_temp = [ones(m,1), X_temp];
  
  %calculo de theta
  theta = normalEqn(X_temp, y)
  
  %calulo del error para esa columna
  pre = X_temp * theta;

  error = absError(m, pre, y);
  %guardamos el numero de la columna con su error correspondiente
  error_list(i,:) = [i,error];

endfor

%clear X_temp
clear X_temp;

fprintf "APARTADO B\n"
fprintf "Lista de errores\n"
error_list
%ordena la matriz en base a la segunda columna con los errores y guardamos los 5 mejores
best5 = sortrows(error_list, 2)(1:5,:);
%Imprime los 5 valores
fprintf "Mejores 5\n"
best5

fprintf "APARTADO C\n"
%repite con los 5 mejores valores

for i = 1:size(best5,1)
  
  %Limpiamos la variable temporal en cada iteracion
  clear X_temp;
  
  col = best5(i,1);
  X_temp = X(:,col);
  
endfor

%anadimos una columna de unos
X_temp = [ones(m,1), X_temp];
  
%calculo de theta
fprintf "Thetas 5 mejores\n"
theta = normalEqn(X_temp, y)
  
%calulo del error para esa columna
pre = X_temp * theta;

fprintf "Error 5 mejores\n"
error = absError(m, pre, y)

fprintf "\nAPARTADO E\n"

%Separamos conjuntos de train y test por cada columna del ocnjunto de X
%asignamos el porcentaje de entrenamiento el resto sera test
percent = 0.7;

fprintf "Thetas calculadas en Holdout 70/30\n"
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
  theta = normalEqn(X_train, y_train)
  
  %calulo del error para esa columna
  pre = X_test * theta;

  error = absError(m_test, pre, y_test);
  %guardamos el numero de la columna con su error correspondiente
  error_listHoldout(i,:) = [i,error];

endfor

fprintf "Lista errores en Holdout 70/30\n"
error_listHoldout

%imprime los mejores 5 resultados
best5Holdout = sortrows(error_listHoldout, 2)(1:5,:);

fprintf "Mejores 5 en Holdout 70/30\n"
best5Holdout

%repite con los 5 mejores valores
for i = 1:size(best5Holdout,1)
  
  %Limpiamos la variable temporal en cada iteracion
  clear X_temp;
  
  col = best5Holdout(i,1);
  X_temp = X(:,col);

endfor

%realizamos la separacion en train y test
[X_trainBest,y_trainBest, X_test, y_test] = holdout(X_temp, y, m, percent);
  
m_train = length(y_train);
m_test = length(y_test);
  
%anadimos una columna de unos
X_trainBest = [ones(m_train,1), X_trainBest];
X_test = [ones(m_test,1), X_test];
  
%calculo de theta
fprintf "Thetas calculadas para 5 mejores en Holdout 70/30\n"
theta = normalEqn(X_trainBest, y_trainBest)
  
%calulo del error para esa columna
pre = X_test * theta;

fprintf "Error calculado en Holdout 70/30\n"
error = absError(m_test, pre, y_test)


%%-------------------------------------------------------
%%EJERCICIO 2 DESCENSO DEL GRADIENTE
%%-------------------------------------------------------

%%Descenso con todo el conjunto de datos

%realizamos la separacion en train y test
[X_train,y_train, X_test, y_test] = holdout(X, y, m, percent);

%%Inicializamos alpha y num iteraciones
alpha = 0.0000003;
iterations = 400;

%inicializamos theta con ceros al tama�o de X_train
theta_grad = zeros(size(X_train, 2), 1);

%Aplica descenso del gradiente
[theta, J_history] = gradientDescent(X_train, y_train, theta_grad, alpha, iterations);

%pintamos la grafica de convergencia
graficaConvergencia(J_history);


%%--------------------------------------------------------------------------------
%%Descenso con los 5 mejores

%%Inicializamos alpha y num iteraciones
alpha = 0.000003;
iterations = 1000;

%inicializamos theta con ceros al tama�o de X_train
theta_grad = zeros(size(X_trainBest, 2), 1);

%Aplica descenso del gradiente
[theta, J_history] = gradientDescent(X_trainBest, y_trainBest, theta_grad, alpha, iterations);

%pintamos la grafica de convergencia
graficaConvergencia(J_history);

  
  
  
  