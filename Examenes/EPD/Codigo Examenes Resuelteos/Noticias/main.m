clear;

rawdata = load("noticias.txt");

X = rawdata(:,1:end-1);
y = rawdata(:,end);

%feature scaling
X = (X-mean(X))./(max(X)-min(X)).*6-3;

[m n] = size(X);
X = [ones(m,1) X];

theta = zeros(n+1, 1);

[J grad] = costFunction(theta, X, y, m);
printf("Cost for initial theta: %f\n", J);

[Jhist grad] = gradientDescentOptimization (theta, X, y, m, 0.001, 10);

plot(Jhist);




