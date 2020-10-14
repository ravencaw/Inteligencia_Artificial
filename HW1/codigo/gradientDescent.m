function [theta, J_history] = gradientDescent(X, y, theta, alpha, iterations)
  
  %calculamos tamaño de y
  m = length(y);
  %inicializamos el historial de costes con el numero de iteraciones
  J_history = zeros(iterations, 1);
  
  %descenso del gradiente
  for i = 1:iterations
    
    %calculo de la nueva theta
    theta = theta - alpha* (1/m) * (X' * (X * theta - y));
    %calcula el coste y guarda en el historial
    J_history = computeCost(X, y, theta); 
    
  endfor
  
endfunction
