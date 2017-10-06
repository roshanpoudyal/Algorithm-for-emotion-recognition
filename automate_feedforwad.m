% automate feedforwad

emotion2list = {'anger', 'boring','disgust', 'happy', 'fear','sad'};
typelist = {'LPC','MFCC'};
speakerCount = {1,2,3,4,5,6,7,8,9,10};
beginning = 'utteranceResults/confmat';
utterancewise = 'utterancewise';
underscore = '_';
extension = '.mat';
countWatch = 0;

% for i = 1:length(typelist)
    for j = 1:length(emotion2list)
        for k = 1:length(speakerCount)        
            matfile = strcat( beginning, underscore, ...
                                utterancewise, underscore, ...
                                emotion2list(j),underscore,...
                                typelist{2}, underscore, ...
                                num2str(k),underscore,extension);
            [confusionMat, acc] = feedforwad(list, 'neutral', emotion2list(j),...
                                              'MFCC',k,1,1);
            save(matfile{1}, 'confusionMat','acc');                     
        end
    end
% end