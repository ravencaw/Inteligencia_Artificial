function p = predict(theta, X)
  
  m = size(X, 1);
  h = sigmoid(X*theta);
  
  p = zeros(m,1);
  for i=1:m
    if (h(i) > 0.5)
      p(i) = 1;
    end
  end
  
end
