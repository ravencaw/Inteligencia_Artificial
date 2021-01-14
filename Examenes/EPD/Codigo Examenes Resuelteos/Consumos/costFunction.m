function [J grad] = costFunction(theta, X, y, m)    
    h = sigmoid(X*theta);
    grad = (1/m)*X'*(h-y);
    J = (-1/m)*sum(y.*log(h)+(1-y).*log(1-h)); 
end
  
  