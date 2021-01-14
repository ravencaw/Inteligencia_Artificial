function [accuracy predictions] = predict(grad, X, y)
  
  m = size(X,1);
  predictions = zeros(m,1);
  
  h = sigmoid(X*grad);
  
  for i=1:m
    if (h(i)>0.5)
      predictions(i) = 1;
    else
      predictions(i) = 0;
    end
   end
   
   accuracy = mean(double(predictions==y));
   
end