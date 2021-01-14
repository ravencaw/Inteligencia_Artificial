function [J theta] = costFunction (theta, X, y)
  
  m = size(X, 1);
  h = sigmoid(X*theta);
  J = (-1/m) * sum(y.*log(h)+(1-y).*log(1-h));
  theta = (1/m)*(X'*(h-y));
  
end
