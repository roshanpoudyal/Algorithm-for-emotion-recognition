function out = takeSamplesWithEmoSpeaker(list, speakerID, emotion,type)
    emotionLabels = {'anger', 'boring','disgust', ...
        'happy', 'fear','sad', 'neutral' };
    out = [];
    emoIndex = strmatch(emotion, emotionLabels);
    for i = 1:size(list{emoIndex, speakerID}, 1)
        if(strcmp(type, 'LPC')==1)
            temp = list{emoIndex, speakerID}(i).lpcCoeffs;
            isNaNMat = isnan(temp);
            rows = unique(mod(find(isNaNMat==1), size(temp,1)));
            rows(rows==0) = size(temp,1);
            temp(rows, :) = [];
            out = cat(1, out, temp);
        elseif(strcmp(type, 'MFCC')==1)
            temp = list{emoIndex, speakerID}(i).mfcc;
            isNaNMat = isnan(temp);
            rows = unique(mod(find(isNaNMat==1), size(temp,1)));
            rows(rows==0) = size(temp,1);
            temp(rows, :) = [];
            temp = (temp - min(min(temp)))./(max(max(temp)) - min(min(temp)));
            out = cat(1, out, temp);
        end
    end
end