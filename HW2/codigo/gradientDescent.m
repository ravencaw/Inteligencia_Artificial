function [theta, J_history] = gradientDescent(X, y, theta, alpha, iterations)
  
  m = length(y);
  J_history = zeros(iterations,1);
  
  for iter = 1:iterations
    
    theta = theta - alpha * (1/m) * (X' * (sigmoid(X * theta) - y));
    fprintf('Theta at iteration %d:\t%.6f\t%.6f\t%.6f\n', iter,theta(1,1),theta(2,1),theta(3,1));
    [J_history(iter), grad] = costFunction(X, y, theta);
    
  endfor
  
endfunction