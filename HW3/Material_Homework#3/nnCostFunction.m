function [J, grad] = nnCostFunction (nn_params, input_layer_size, hidden_layer_size, num_labels, X, y, lambda)
  
  theta1 = reshape(nn_params(1:(hidden_layer_size * (input_layer_size + 1))), ...
                hidden_layer_size, (input_layer_size+1));
                
  anterior = hidden_layer_size * (input_layer_size + 1);
                
  theta2 = reshape(nn_params((anterior + 1): end), num_labels, (hidden_layer_size+1));
  
  m = size(X,1);
  suma = 0;
  
  DELTA1 = zeros(hidden_layer_size, (input_layer_size+1));
  DELTA2 = zeros(num_labels, (hidden_layer_size+1));
  
  for i = 1:m
    [a1 a2 a3] = fordward(theta1,theta2,X,i);
    
    aux = (1:num_labels == y(i));
    h = a3;
    
    suma = suma + aux * log(h) + (1 - aux) * log(1 - h);
    
    delta3 = a3-aux';
    delta2 = (theta2' * delta3) .* ((1-a2).*a3);
    delta2 = delta2(2:end);
    
    DELTA1 = DELTA1 + delta2*a1';
    DELTA2 = DELTA2 + delta3*a2';
    
  endfor
  
  J = (-1/m) * suma;
  
  DELTA1 = (1/m) * DELTA1;
  DELTA2 = (1/m) * DELTA2;
  
  grad = [DELTA1(:); DELTA2(:)];
  
endfunction