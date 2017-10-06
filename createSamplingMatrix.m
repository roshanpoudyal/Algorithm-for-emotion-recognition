function [training, labels] = createSamplingMatrix(list, speakerIndex)
emotionLabels = {'anger', 'boring','disgust', 'happy', 'fear','sad', 'neutral' };

temp = list(:, speakerIndex);
lpcCoeffs = [];
labels = {};

for i = 1: size(temp,1)
    for j = 1:length(temp{i,1})
        lpcCoeff = (temp{i,1}(j).lpcCoeffs)';
%         lpcCoeff(:,1) = [];
%         prevSize = length(lpcCoeffs);
        lpcCoeffs = cat(1, lpcCoeffs, lpcCoeff);
        tempLabel = cell(size(lpcCoeff,1), 1);
        for k = 1: size(lpcCoeff,1)
            tempLabel{k,1} = emotionLabels{i};
        end
        labels = [labels; tempLabel];
%         labels(prevSize+1:prevSize+length(lpcCoeff)) = i;
    end
end

% model = fitcknn(lpcCoeffs', labels', 'NumNeighbors',5);
% labels = labels';
training = lpcCoeffs;
end