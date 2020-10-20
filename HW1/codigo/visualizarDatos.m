function visualizarDatos(best, bestTheta, J_history, J_historyBest5, y)
  
  %histograma del porcentaje de grasa corporal con todas las instancias
  %Calcula numero de instancias
  n = length(y);
  figure;
  subplot(2,2,1);
  hist(y,n, "facecolor", "b", "edgecolor", "b");
  hold on;
  ylabel('Porcentaje grasa corporal');
  hold off;
  
  %Mejor atributo frente al % de grasa y recta de regresion
  subplot(2,2,2);
  hold on;
  plot(best,y,'+b');
  hold on;
  m = length(best);
  best = [ones(m,1), best];
  aux = best*bestTheta;  
  plot(best(:,2), aux, '-r');
  hold on;
  xlabel('Densidad por pesaje bajo agua');
  ylabel('Porcentaje de masa corporal');
  hold off;
  
  %grafica de convergencia con todos los atributos
  subplot(2,2,3);
  graficaConvergencia(J_history);

  %grafica de convergencia con los 5 mejores
  subplot(2,2,4);
  graficaConvergencia(J_historyBest5);
  hold off;
  
endfunction
