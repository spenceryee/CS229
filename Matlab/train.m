addpath('/afs/.ir.stanford.edu/users/s/p/spencery/CS229/libsvm-3.20/matlab');  % add LIBLINEAR to the path
% load newdat.mat
load TFEIDX.dat
load TFEIDy.dat
load CK_X.dat
load CK_y.dat
load JAFFEX.dat
load JAFFEy.dat

%[sparseTrainMatrix, trainCategory] = readMatrix('LANDMARKS.TRAIN');
%newtrain =
%newtrain = [TrainMatrix(:, 1:91) TrainMatrix(:, 93:95) TrainMatrix(:, 97) TrainMatrix(:, 99:109) TrainMatrix(:, 111:117) TrainMatrix(:, 119:129) TrainMatrix(:, 131:167)];
%newtrain = TrainMatri
calculateTFEIDAngles;
calculateCKAngles;
newMatrix = [angledatTFEID; angledatCK];%; CK_Matrix];%(:, 2:167)];
newCategory = [TFEIDy; CK_y];%; CK_Category];%; CKCategory];

%numTrainDocs = size(newtrain, 1);
%numTokens = size(newtrain, 2);

model = svmtrain(newCategory, newMatrix,'-v 2 -g 0.78 -c 2.5 -q');
svmtrain(newCategory, newMatrix,'-v 5 -g 0.78 -c 2.5 -q');
svmtrain(newCategory, newMatrix,'-v 10 -g 0.78 -c 2.5 -q');
%svmtrain(newCategory, newMatrix,'-v 10 -g 0.0005 -c 2.5 -q');
%svmtrain(newCategory, newMatrix,'-v 2 -g 0.0007 -c 2.5 -q');
%svmtrain(newCategory, newMatrix,'-v 5 -g 0.0007 -c 2.5 -q');
%svmtrain(newCategory, newMatrix,'-v 10 -g 0.0007 -c 2.5 -q');

% [sparseTestMatrix, tokenlist, testCategory] = readMatrix('MATRIX.TEST');
%
% numTestDocs = size(sparseTestMatrix, 1);
% numTokens = size(sparseTestMatrix, 2);

%testMatrix = normalize(CK_Matrix(2:2:388, :));
%output = svmpredict(CK_Category(2:2:388), testMatrix, model, 0);

