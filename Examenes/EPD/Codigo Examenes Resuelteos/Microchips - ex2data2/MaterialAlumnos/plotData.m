function plotData(X, y)
  
 plot(X((y==0),1), X((y==0),2), "^r"); 
 hold on;
 plot(X((y==1),1), X((y==1),2), "+"); 
 
 
 
end
