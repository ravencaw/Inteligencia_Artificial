function W = randInitializeWeights(n, s, epsilon)
  
  W = zeros(n, s);
  W = rand(n, s) * 2 * epsilon - epsilon;  

end  