load CK_X.dat
load CK_y.dat
load TFEIDX.dat
load TFEIDy.dat
load JAFFEX.dat
load JAFFEy.dat

% CK_angles = calculateAngles(CK_X);
% calculateTFEIDAngles;
% calculateJAFFEAngles;

overallConfusion = zeros(8, 8);
overallAccuracy = 0;
fold = 5;
for j=1:fold

angles = [calculateAngles(TFEIDX); calculateAngles(CK_X); calculateAngles(JAFFEX)];
y = [TFEIDy; CK_y; JAFFEy];
newMatrix = []; testMatrix = [];
newCategory = []; testCategory = [];

m = size(angles, 1);
for k=1:fold
    if j~=k
        newMatrix = [newMatrix; angles(k:fold:m, :)];
        newCategory = [newCategory; y(k:fold:m)];
    else
        testMatrix = angles(k:fold:m, :);
        testCategory = y(k:fold:m);
    end
end

[B, dev, stats] = mnrfit(newMatrix, newCategory);
pihat = mnrval(B, testMatrix);
[C, I] = max(pihat');
diff = testCategory - I';
[blah, size1] = size(I);
count = 0;
confusionMatrix = zeros(8, 8);
for i=1:size1
	if diff(i) == 0
        count = count + 1;
    end
    confusionMatrix(testCategory(i), I(i)) = confusionMatrix(testCategory(i), I(i)) + 1;
end
accuracy = count / size1
confusionMatrix
overallAccuracy = overallAccuracy + accuracy/fold;
overallConfusion = overallConfusion + confusionMatrix;

end
overallAccuracy
overallConfusion
overallConfusion ./ repmat(sum(overallConfusion, 2), 1, 8)