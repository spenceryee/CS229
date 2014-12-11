addpath('/Applications/MATLAB_R2014b.app/bin/maci64/libsvm-3.20/matlab');  % add LIBLINEAR to the path
% load newdat.mat
load TFEIDX.dat
load TFEIDy.dat
load CK_X.dat
load CK_y.dat
load JAFFEX.dat
load JAFFEy.dat

CK_norm = normalize(CK_X);
TFEIDnorm = normalize(TFEIDX);
JAFFEnorm = normalize(JAFFEX);
CK_angles = calculateAngles(CK_X);
TFEIDangles = calculateAngles(TFEIDX);
JAFFEangles = calculateAngles(JAFFEX);
mult = 35;

X0 = [CK_norm;TFEIDnorm;JAFFEnorm];
X1 = [mult*CK_angles;mult*TFEIDangles;mult*JAFFEangles];
X2 = X1;%[X0 X1];
y = [CK_y; TFEIDy;JAFFEy];

fold = 2;
overallAccuracy = 0;
overallConfusion = zeros(8, 8);
for j=1:fold

    newMatrix = []; testMatrix = [];
    newCategory = []; testCategory = [];
    m = size(X2, 1);
    for k=1:fold
        if j~=k
            newMatrix = [newMatrix; X2(k:fold:m, :)];
            newCategory = [newCategory; y(k:fold:m)];
        else
            testMatrix = X2(k:fold:m, :);
            testCategory = y(k:fold:m);
        end
    end

    s = ' -g 0.00050 -c 2.5';

    model = svmtrain(newCategory, newMatrix, strcat('-q', s));
    output = svmpredict(testCategory, testMatrix, model, 0);
    count = 0;
    confusionMatrix = zeros(8, 8);
    diff = testCategory - output;
    numTest = size(output, 1);
    for i=1:numTest
        if diff(i) == 0
            count = count + 1;
        end
        confusionMatrix(testCategory(i), output(i)) = confusionMatrix(testCategory(i), output(i)) + 1;
    end
    accuracy = count / numTest;
    overallAccuracy = overallAccuracy + accuracy/fold;
    overallConfusion = overallConfusion + confusionMatrix;
end
overallAccuracy
overallConfusion
%round(100* overallConfusion ./ repmat(sum(overallConfusion, 2), 1, 8), 2)