function [confMatrix, accuracy] = feedforwad(list, emotion1, emotion2, type, speakerID, isUpDownSampling, isUtterancewise)
    indicesTraining = 1:10;
    indicesTraining(indicesTraining==speakerID) = [];    
   
%     net = feedforwardnet(100, 'trainrp');
%     net = feedforwardnet(40);
    net = feedforwardnet([40 40]); %%!!!! TWO HIDDEN LAYERS, EACH NUMBER SHOWS THE NUMBER OF NEURONS IN EACH
    %%HIDDEN LAYER
%     net=newff([0 21],[2 1],{'tansig' 'purelin'});
%     net = configure(net,samples',labels');
    net.layers{2}.transferFcn = 'logsig';
%     net.trainParam.max_fail = 100;
%     net.trainParam.min_grad = 1e-10;
%     net.trainParam.max_fail = 3;
%     net.trainParam.lr = 0.001;
%     net.trainParam.mc = 0.09;
%     net.trainParam.mu_dec = 0.01;
%     net.trainParam.mu_inc = 1;
%     net.trainParam.mu =  1;
%     net = train(net,samples',labels');
    if isUtterancewise==0
        emotionLabels = {'anger', 'boring','disgust', ...
            'happy', 'fear','sad', 'neutral' };
        
        emoIndices = [strmatch(emotion1, emotionLabels), strmatch(emotion2, emotionLabels)];
        emotion1Samples = [];
        emotion2Samples = [];
            for i = 1: size(indicesTraining)
                for j = 1:size(list{emoIndices(1), indicesTraining(i)}, 1)
                    if( strcmp(type, 'LPC')==1)
                        emotion1Samples = cat(2, emotion1Samples, list{emoIndices(1), indicesTraining(i)}(j).lpcCoeffs);
                    else
                        emotion1Samples = cat(2, emotion1Samples, list{emoIndices(1), indicesTraining(i)}(j).mfcc);
                    end
                end
                
                for j = 1:size(list{emoIndices(2), indicesTraining(i)}, 1)
                    if( strcmp(type, 'LPC')==1)
                        emotion2Samples = cat(2, emotion2Samples, list{emoIndices(2), indicesTraining(i)}(j).lpcCoeffs);
                    else
                        emotion2Samples = cat(2, emotion2Samples, list{emoIndices(2), indicesTraining(i)}(j).mfcc);
                    end
                end
            end
            [emotion1Samples, emotion2Samples] = upDownSample(emotion1Samples, emotion2Samples, isUpDownSampling);
        
            labels1 = zeros(2, size(emotion1Samples,2));
            labels2 = zeros(2, size(emotion2Samples,2));
            labels1(1,:) = 1;
            labels2(2,:) = 1;

            labels = cat(2, labels1, labels2);
            samples = cat(2, emotion1Samples, emotion2Samples);
            
            [net, tr] = train(net, samples, labels);
            
            accuracy = [];
            class = [];
            original = [];
            for i = 1:length(emoIndices)
                emotion = emoIndices(i);
                for j = 1:size(list{emotion, speakerID}, 1)
                    test = [];
                    if( strcmp(type, 'LPC')==1)
                        test = list{emotion, speakerID}(j).lpcCoeffs;
                    else
                        test = list{emotion, speakerID}(j).mfcc;
                    end
                    c = net(test);
                    [~, c] = max(c,[], 1);
                    c1 = sum(c==i);
                    c2 = sum(c~=i);
                    if c1>=c2
                        c = i;
                    else
                        c = i+1;
                    end
                    accuracy = cat(2, accuracy, c == i);
                    original = cat(2, original, i);
                    if c==i
                        class = cat(2, class, i);
                    elseif i==1
                        class = cat(2, class, 2);
                    else
                        class = cat(2, class, 1);
                    end
                end
            end
            
        accuracy = sum(accuracy) / length(accuracy);

        confMatrix = confusionmat(original, class);
        plotconfusion(original, class);
    end
    if isUtterancewise==1
        emotionLabels = {'anger', 'boring','disgust', ...
            'happy', 'fear','sad', 'neutral' };
        
        emoIndices = [strmatch(emotion1, emotionLabels), strmatch(emotion2, emotionLabels)];
        emotion1Samples = [];
        emotion2Samples = [];
            for i = 1: size(indicesTraining)
                for j = 1:size(list{emoIndices(1), indicesTraining(i)}, 1)
                    if( strcmp(type, 'LPC')==1)
                        emotion1Samples = cat(2, emotion1Samples, list{emoIndices(1), indicesTraining(i)}(j).lpcCoeffs);
                    else
                        emotion1Samples = cat(2, emotion1Samples, list{emoIndices(1), indicesTraining(i)}(j).mfcc);
                    end
                end
                
                for j = 1:size(list{emoIndices(2), indicesTraining(i)}, 1)
                    if( strcmp(type, 'LPC')==1)
                        emotion2Samples = cat(2, emotion2Samples, list{emoIndices(2), indicesTraining(i)}(j).lpcCoeffs);
                    else
                        emotion2Samples = cat(2, emotion2Samples, list{emoIndices(2), indicesTraining(i)}(j).mfcc);
                    end
                end
            end
            [emotion1Samples, emotion2Samples] = upDownSample(emotion1Samples, emotion2Samples, isUpDownSampling);
        
            labels1 = zeros(2, size(emotion1Samples,2));
            labels2 = zeros(2, size(emotion2Samples,2));
            labels1(1,:) = 1;
            labels2(2,:) = 1;

            labels = cat(2, labels1, labels2);
            samples = cat(2, emotion1Samples, emotion2Samples);
            
            [net, tr] = train(net, samples, labels);
            testSamples = [];
            original = [];
            for i = 1:length(emoIndices)
                emotion = emoIndices(i);
                for j = 1:size(list{emotion, speakerID}, 1)
                    test = [];
                    if( strcmp(type, 'LPC')==1)
                        test = list{emotion, speakerID}(j).lpcCoeffs;
                    else
                        test = list{emotion, speakerID}(j).mfcc;
                    end
                    testSamples = cat(2, testSamples, test);
                    o = zeros(1, size(test,2));
                    o(:) = i;
                    original = cat(2, original, o);
                end
            end
            
            
        class = net(testSamples);
        [~, class_index] = max(class,[], 1);
        accuracy = class_index==original;
        accuracy = sum(accuracy) / length(accuracy);

        confMatrix = confusionmat(class_index, original);
        plotconfusion(original, class_index);
    end
    
end

function out = concatSamples(list, emotion,type, indices)
out = [];
%emotionLabels = {'anger', 'boring','disgust', ...
%        'happy', 'fear','sad', 'neutral' };
for i = 1:length(indices)
    out = cat(1, out, takeSamplesWithEmoSpeaker(list, ...
        indices(i), emotion,type));
end
%labels = zeros(size(out,1), 1);
%label = strmatch(emotion, emotionLabels);
%labels(:) = label;
end

function [emotion1Samples, emotion2Samples] = upDownSample(emotion1Samples, emotion2Samples, isUpDownSampling)
    if isUpDownSampling == 0
        s_min = min(size(emotion1Samples,2), size(emotion2Samples, 2));
        if size(emotion1Samples,2) > size(emotion2Samples,2)
            emotion1Samples = downSampleMatrix(emotion1Samples, s_min);
        elseif size(emotion1Samples,2) < size(emotion2Samples,2)
            emotion2Samples = downSampleMatrix(emotion2Samples, s_min);
        end
    elseif isUpDownSampling ==1
        s_max = max(size(emotion1Samples,2), size(emotion2Samples, 2));
        if size(emotion1Samples,2) > size(emotion2Samples,2)
            emotion2Samples = upsampleMatrix(emotion2Samples, s_max);
        elseif size(emotion1Samples,2) < size(emotion2Samples,2)
            emotion1Samples = upsampleMatrix(emotion1Samples, s_max);
        end
    end
end