rawdata_test = load("faces_lr.test");
rawdata_train = load("faces_lr.data");

%Step 1: prepare data
X = rawdata_train(:,1:end-1);
Xtest = rawdata_test(:,1:end-1);

y = rawdata_train(:,end);
ytest = rawdata_test(:,end);

[m n] = size(X);
k = 1;
s = 4;

%1.1 Initialize and unroll thetas
theta1 = randInitializeWeights (n, s);
theta2 = randInitializeWeights (s, 1);

nn_params = [theta1(:); theta2(:)];

%1.2 Prepare costFunction
[J grad] = nnCostFunction(nn_params, n, s, X, y);
printf("Accuracy of first prediction: %f percent",J*100);

%Step 2: train the NN with training set

