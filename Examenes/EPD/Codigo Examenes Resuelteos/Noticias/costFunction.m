function [J theta] = costFunction(theta, X, y, m)

  h = X*theta;
  theta = (1/m)*X'*(h-y);
  J = (1/2*m)*sum((h-y).^2);
  
end