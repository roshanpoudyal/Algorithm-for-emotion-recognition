function out = utteranceWiseClassification(net, audioFile, type)
    sampleMatrix = audioFile.mfcc;
    if strcmp(type, 'LPC')==1
        sampleMatrix = audioFile.lpcCoeffs;
    end
    
    
    labels = net(sampleMatrix');
    minV = min(labels);
    maxV = max(labels);
    labels = (labels - minV)./(maxV - minV);
    labels = round(labels);
    out = mymax(labels);
end