function [J grad] = nnCostFunction(nn_params, n, s, X, y)
  
  m = size(X,1);
  theta1 = reshape(nn_params(1:(n+1)*s), s, n+1);
  theta2 = reshape(nn_params((n+1)*s+1:end), 1, s+1);
  D1 = zeros(s, n+1);
  D2 = zeros(1, s+1);
  sum = 0;
  
  for i=1:m
    % STEP 3.1: FORWARD PROPAGATION
    a1 = X(i,:)'; %We take a row of X (an example) and transpose it as a vector column
    a1 = [1; a1];
    z2 = theta1*a1;
    a2 = sigmoid(z2);
    a2 = [1; a2];
    z3 = theta2*a2;
    a3 = sigmoid(z3); 
    
    %STEP 3.2: BACKPROPAGATION    
    %3.2.1: Calculate gradients D1 & D2
    delta3 = a3 - y(i);
    delta2 = (theta2'*delta3).*(a2.*(1-a2));
    delta2 = delta2(2:end);
    D1 = D1 + delta2 * a1';
    D2 = D2 + delta3 * a2';
    %3.2.2: Calculate J
    h = a3;
    sum = sum + y(i)*log(h)+(1-y(i))*log(1-h);
  end
  %STEP 3.3: BACKPROPAGATION RESULTS
  D1 = (1/m)*D1;
  D2 = (1/m)*D2;
  J = (-1/m)*sum;  
  grad = [D1(:); D2(:)];  
end

  
  
  