rawdata = load("consumos.txt");

X = rawdata(:,1:end-1);
y = rawdata(:,end);

[m n] = size(X);

HOLDOUT = 0.7;

%feature scaling
X = ((X-mean(X))./(max(X)-min(X))).*6-3;

X = [ones(m,1) X];
Xtrain = X(1:round(HOLDOUT*m), :);
Xtest = X(round(HOLDOUT*m)+1:end, :);
ytrain = y(1:round(HOLDOUT*m));
ytest = y(round(HOLDOUT*m)+1:end);

theta = zeros(n+1, 1);

[J grad] = costFunction(theta, X, y, m);
printf("Coste con theta=0: %f", J);

%costFunc = @(p)costFunction(p, X, y, m);

%options = optimset("GradObj", "on", "MaxIter",50);
%[grad J] = fminunc(costFunc, theta, options);

[accuracy predictions] = predict(grad, Xtest, ytest);
printf("Accuracy: %f percent \n", accuracy*100);