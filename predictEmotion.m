function output = predictEmotion(vector)
addpath('/Applications/MATLAB_R2014b.app/bin/maci64/libsvm-3.20/matlab');

load model.mat

ex = 35*calculateAngles(vector); %[normalize(vector) mult*calculateAngles(vector)];
blah = ones(size(vector, 1), 1);
emotions = ['anger    ';'contempt ';'disgust  ';'fear     ';'happiness';'neutral  ';'sadness  ';'surprise '];
output = emotions(svmpredict(blah, ex, model, '-q'), :);
