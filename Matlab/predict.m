function output = predict(vector)
addpath('/Applications/MATLAB_R2014b.app/bin/maci64/libsvm-3.20/matlab');

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
X2 = [X0 X1];
y = [CK_y; TFEIDy;JAFFEy];

s = ' -g 0.00050 -c 2.5';
model = svmtrain(y, X2, strcat('-q', s));
ex = [normalize(vector) mult*calculateAngles(vector)];
blah = ones(size(vector, 1), 1);
emotions = ['anger    ';'contempt ';'disgust  ';'fear     ';'happiness';'neutral  ';'sadness  ';'surprise '];
output = emotions(svmpredict(blah, ex, model, 0), :);