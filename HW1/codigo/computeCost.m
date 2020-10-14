function J = computeCost(X, y, theta)
  
  %calcula tamaño de y
  m = length(y);
  %calcula la prediccion
  pre = X * theta;
  
  %calcula el coste
  J =  (1/m) * sum(abs(pre-y));
  
endfunction
