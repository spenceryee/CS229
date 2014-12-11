load CK_X.dat
load CK_y.dat
load TFEIDX.dat
load TFEIDy.dat
load JAFFEX.dat
load JAFFEy.dat

calculateCKAngles;
calculateTFEIDAngles;
calculateJAFFEAngles;

newMatrix = [TFEIDX(:,1) angledatTFEID; CK_X(:,1) angledatCK; JAFFEX(:,1) angledatJAFFE];
newCategory = [TFEIDy; CK_y; JAFFEy];
testMatrix = newMatrix;
testCategory = newCategory;

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
