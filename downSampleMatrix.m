function [emotionDownSample] = downSampleMatrix(emotions, sizeOfEmotionRows)
%     if sizeOfEmotionRows < size(emotions,1)
%         emotionDownSample = datasample(emotions,sizeOfEmotionRows,'Replace',false);
%     end

    emotionDownSample = emotions;
    if(sizeOfEmotionRows<size(emotions,1))
        num = abs(sizeOfEmotionRows - size(emotions,2));
        indices = randperm(size(emotions,2));
        indices = indices(1:num);
        emotionDownSample(:,indices) = [];
    end       
end


% function [emotionDownSample, labelsDownSample] = downSampleMatrix(emotions, labels, sizeOfEmotionRows)
%     if sizeOfEmotionRows < size(emotions,1)
%         [emotionDownSample,downSampledindices] = datasample(emotions,sizeOfEmotionRows,'Replace',false);
%         labelsDownSample = labels(downSampledindices, :);
%     end
% end