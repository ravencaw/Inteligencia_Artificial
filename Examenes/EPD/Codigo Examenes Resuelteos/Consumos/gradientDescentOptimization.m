function [Jhist theta] = gradientDescentOptimization(theta, X, y, m, n, iter, alpha)
  
  Jhist = zeros(iter, 1);
  
  for i=1:iter  
    [J theta] = costFunction(theta, X, y, m);
    Jhist(i) = J;
    theta = theta - alpha*theta;
  end
end