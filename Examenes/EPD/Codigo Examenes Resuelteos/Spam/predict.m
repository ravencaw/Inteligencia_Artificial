function accuracy = predict(theta1, theta2, Xtest, y)
  
  m = size(Xtest, 1);
  
  X = [ones(m,1) Xtest]; %Size mxn+1
  h1 = sigmoid(X*theta1');
  h1 = [ones(m,1) h1]; %Size mxs+1
  h2 = sigmoid(h1*theta2');
  
  predict = zeros(m, 1);
  for i=1:m
    if (h2(i)>0.5)
      predict(i) = 1;
    else 
      predict(i) = 0;
    end
  end
  
  accuracy = mean(double(y==predict));
  
end