function plotData(x, y)
% ============================================================
%PLOTDATA Plots the data points x and y into a new figure 
% ============================================================

figure; % open a new figure window
hold on;

IP = (y == 1);%Indices positivos
IN = (y == 0);%Indices negativos
plot(x(IP,1), x(IP,2), 'bx', 'MarkerSize', 10);
plot(x(IN,1), x(IN,2), 'rx', 'MarkerSize', 10);

hold off;

end