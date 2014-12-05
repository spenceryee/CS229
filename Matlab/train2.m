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
% X0 = [CK_norm;TFEID_norm;JAFFE_norm];
% X1 = [mult*CK_angles2;mult*TFEIDangles2;mult*angledatJAFFE];
% X2 = [X0 X1];
% y = [CK_y; TFEIDy;JAFFEy];
% mult = 35;
% st = 2;
X0 = [CK_norm;TFEIDnorm;JAFFEnorm];
X1 = [mult*CK_angles;mult*TFEIDangles;mult*JAFFEangles];
X2 = [X0 X1];
y = [CK_y; TFEIDy;JAFFEy];

s = ' -g 0.00050 -c 2.5';

% TFEIDs = 73;
% TFEIDe = 161;
% CKs = 47;
% CKe = 63;
% JAFFEs = 185;
% JAFFEe = 213;
%model = svmtrain(y, X2, strcat('-q', s));
% X0 = JAFFEnorm(1:2:213, :);%[CK_norm(CKs:2:CKe, :); TFEIDnorm(TFEIDs:2:TFEIDe, :)];%; JAFFEnorm(JAFFEs:2:JAFFEe, :)];
% X1 = mult*JAFFEangles(1:2:213, :);%[mult*CK_angles(CKs:2:CKe, :); mult*TFEIDangles(TFEIDs:2:TFEIDe, :)];%; mult*JAFFEangles(JAFFEs:2:JAFFEe, :)];
% X2 = [X0 X1];
% y = JAFFEy(1:2:213);%[CK_y(CKs:2:CKe); TFEIDy(TFEIDs:2:TFEIDe)];%; JAFFEy(JAFFEs:2:JAFFEe)];
output = svmpredict(y, X2, model, 0);
%output'
% model = svmtrain(y, X0, strcat('-v 2 -q', s));
% model = svmtrain(y, X0, strcat('-v 5 -q', s));
% model = svmtrain(y, X0, strcat('-v 10 -q', s));
% model = svmtrain(y, X1, strcat('-v 2 -q', s));
% model = svmtrain(y, X1, strcat('-v 5 -q', s));
% model = svmtrain(y, X1, strcat('-v 10 -q', s));
% svmtrain(y, X2, strcat('-v 2 -q', s));
% svmtrain(y, X2, strcat('-v 5 -q', s));
% svmtrain(y, X2, strcat('-v 10 -q', s));



% % Compute the error on the test set
% error=0;
% for i=1:numTrainDocs
%   if (trainCategory(i) ~= output(i))
%     error=error+1;
%   end
% end
%
% %Print out the classification error on the test set
% error/numTrainDocs