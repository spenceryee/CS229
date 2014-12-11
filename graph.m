load CK_X.dat
load CK_y.dat
load TFEIDX.dat
load TFEIDy.dat
load JAFFEX.dat
load JAFFEy.dat

A = [0 repmat([125 0], 1, 83)];
CK_norm = normalize(CK_X) - repmat(A, 388, 1);
TFEIDnorm = normalize(TFEIDX);
JAFFEnorm = normalize(JAFFEX) + repmat(A, 213, 1);

for i=1:83
    x = CK_norm(1:388, 2*i);
    y = -CK_norm(1:388, 2*i + 1);
    scatter(x, y, 1, 'red');
    hold on
    x = TFEIDnorm(1:565, 2*i);
    y = -TFEIDnorm(1:565, 2*i + 1);
    scatter(x, y, 1, 'blue');
    hold on
    x = JAFFEnorm(1:213, 2*i);
    y = -JAFFEnorm(1:213, 2*i + 1);
    scatter(x, y, 1, 'green');
    hold on
end
