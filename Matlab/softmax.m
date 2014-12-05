
angles = [TFEIDangles; CK_angles];
y = [TFEIDy; CK_y];
newMatrix = angles;%(2:2:953, :);
newCategory = y;%(2:2:953);
[B, dev, stats] = mnrfit(newMatrix, newCategory);

testMatrix = angles;%(1:2:953, :);
testCategory = y;%(1:2:953);
pihat = mnrval(B, testMatrix);
[C, I] = max(pihat');
             diff = testCategory - I';
             count = 0;
             [blah, size1] = size(I);
             for i=1:size1
             if diff(i) == 0
             count = count + 1;
             end
             end
             
             accuracy = count / size1