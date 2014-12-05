addpath('/afs/.ir.stanford.edu/users/s/p/spencery/CS229/libsvm-3.20/matlab');  % add LIBLINEAR to the path
% load newdat.mat
load TFEIDX.dat
load TFEIDy.dat
load TFEIDangles.dat
load TFEIDangles2.dat
load CK_X.dat
load CK_y.dat
load CK_angles.dat
load CK_angles2.dat
load JAFFEX.dat
load JAFFEy.dat

% CK_norm = normalize(CK_X);
% TFEID_norm = normalize(TFEIDX);
% JAFFE_norm = normalize(JAFFEX);
% mult = 35;
% X0 = [CK_norm;TFEID_norm;JAFFE_norm];
% X1 = [mult*CK_angles2;mult*TFEIDangles2;mult*angledatJAFFE];
% X2 = [X0 X1];
% y = [CK_y; TFEIDy;JAFFEy];
mult = 35;
st = 2;
X0 = [CK_norm(st:2:388, :); TFEID_norm(st:2:565, :); JAFFE_norm(st:2:213, :)];
X1 = [mult*CK_angles2(st:2:388,:);mult*TFEIDangles2(st:2:565,:);mult*angledatJAFFE(st:2:213,:)];
X2 = [X0 X1];
y = [CK_y(st:2:388); TFEIDy(st:2:565); JAFFEy(st:2:213)];

s = ' -g 0.00050 -c 2.5';

TFEIDs = 73;
TFEIDe = 161;
CKs = 47;
CKe = 63;
JAFFEs = 185;
JAFFEe = 213;
model = svmtrain(y, X2, strcat('-q', s));
X0 = JAFFE_norm(1:2:213, :);%[CK_norm(CKs:2:CKe, :); TFEID_norm(TFEIDs:2:TFEIDe, :)];%; JAFFE_norm(JAFFEs:2:JAFFEe, :)];
X1 = mult*angledatJAFFE(1:2:213, :);%[mult*CK_angles2(CKs:2:CKe, :); mult*TFEIDangles2(TFEIDs:2:TFEIDe, :)];%; mult*angledatJAFFE(JAFFEs:2:JAFFEe, :)];
X2 = [X0 X1];
y = JAFFEy(1:2:213);%[CK_y(CKs:2:CKe); TFEIDy(TFEIDs:2:TFEIDe)];%; JAFFEy(JAFFEs:2:JAFFEe)];
output = svmpredict(y, X2, model, 0);
%output'
% model = svmtrain(y, X0, strcat('-v 2 -q', s));
% model = svmtrain(y, X0, strcat('-v 5 -q', s));
% model = svmtrain(y, X0, strcat('-v 10 -q', s));
% model = svmtrain(y, X1, strcat('-v 2 -q', s));
% model = svmtrain(y, X1, strcat('-v 5 -q', s));
% model = svmtrain(y, X1, strcat('-v 10 -q', s));
% model = svmtrain(y, X2, strcat('-v 2 -q', s));
% model = svmtrain(y, X2, strcat('-v 5 -q', s));
% model = svmtrain(y, X2, strcat('-v 10 -q', s));



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