function dat = calculateAngles(X)

features = [30, 36, 34;
            30, 32, 34;
            76, 82, 80;
            76, 78, 80;
            22, 27, 26;
            22, 20, 26;
            68, 73, 72;
            68, 66, 72;
            63, 65, 64;
            63, 59, 64;
            38, 39, 47;
            38, 46, 47;
            38, 48, 47;
            38, 55, 47;
            38, 65, 47;
            22, 36, 26;
            22, 32, 26;
            68, 82, 72;
            68, 78, 72;
            30, 31, 32;
            30, 35, 36;
            35, 36, 37;
            31, 32, 33;
            32, 33, 34;
            36, 37, 34;
            76, 77, 78;
            77, 78, 79;
            78, 79, 80;
            76, 81, 82;
            81, 82, 83;
            82, 83, 80;
            38, 50, 49;
            50, 55, 53;
            52, 53, 47;
            38, 51, 48;
            51, 48, 54;
            48, 54, 47];

[rows, cols] = size(features);
[numEx, numFeat] = size(X);
dat = zeros(numEx, rows);
features = features * 2;
for i=1:rows
a = (X(:, features(i, 1)) - X(:, features(i, 2))) .^ 2 + (X(:, features(i, 1) + 1) - X(:, features(i, 2) + 1)) .^ 2;
b = (X(:, features(i, 3)) - X(:, features(i, 2))) .^ 2 + (X(:, features(i, 3) + 1) - X(:, features(i, 2) + 1)) .^ 2;
c = (X(:, features(i, 1)) - X(:, features(i, 3))) .^ 2 + (X(:, features(i, 1) + 1) - X(:, features(i, 3) + 1)) .^ 2;
dat(:, i) = acos((a + b - c) ./ (2 .* sqrt(a .* b)));
end
