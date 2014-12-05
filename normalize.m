function a = normalize(X)
    examples = size(X, 1);
    a = zeros(examples, 167);
    a(:, 1) = X(:, 1);
    for i=1:examples
        x = (X(i, 42) + X(i, 134))/2;
        y = (X(i, 43) + X(i, 135))/2;
        width = X(i, 134) - X(i, 42);
        height = X(i, 131) - y;
        for j=2:2:166
            a(i, j) = (X(i, j) - x) * 50 / width;
            a(i, j + 1) = (X(i, j + 1) - y) * 50 / width;
        end
    end