function graficaConvergencia(J_history)
  
  %Esta funcion no tiene un figure ya que se llama desde la funcion visualizarDatos
  
  plot(1:length(J_history),J_history, '-b', 'LineWidth',2);
  hold on;
  ylabel('Cost');
  xlabel('Number of iterations');
  hold off;
  
endfunction