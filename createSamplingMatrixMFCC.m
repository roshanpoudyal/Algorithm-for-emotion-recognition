function [training, labels] = createSamplingMatrixMFCC(list, speakerIndex)
temp = list(:, speakerIndex);
mpcCoeffs = [];
labels = [];

for i = 1: size(temp,1)
    for j = 1:length(temp{i,1})
        mpcCoeff = (temp{i,1}(j).mfcc');
        mpcCoeffs = [mpcCoeffs; mpcCoeff];
        labels = [labels; i];
%         labels(prevSize+1:prevSize+length(lpcCoeff)) = i;
    end
end

% model = fitcknn(lpcCoeffs', labels', 'NumNeighbors',5);
% labels = labels';
training = mpcCoeffs;
end