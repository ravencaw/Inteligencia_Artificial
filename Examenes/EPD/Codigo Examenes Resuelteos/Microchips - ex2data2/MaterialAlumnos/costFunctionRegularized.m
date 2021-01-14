function [J, theta] = costFunctionRegularized(theta, X, y, lambda)

  [m n] = size(X);
  
  h = sigmoid(X*theta);

  jPenalty = (lambda/(2*m))*sum(theta(2:n).**2);
  J = (-1/m)*sum(y.*log(h)+(1-y).*log(1-h)) + jPenalty;
  
  theta_penalty = (lambda/m)*[0; theta(2:n)];
  theta = (1/m)*(X'*(h-y)) - theta_penalty;


  
end