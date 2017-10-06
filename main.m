clear
clc
addpath('voicebox/');
warning('off', 'all');
path = 'EmoDB/wav/';
speakers = {'03', '08', '09', '10', ...
        '11', '12','13','14','15','16'};
emotions = {'*W*.wav', '*L*.wav', '*E*.wav', '*F*.wav', '*A*.wav', '*T*.wav', '*N*.wav'};
list= {};
for i = 1: length(emotions)
    %list{i} = {};
    for j = 1: length(speakers)
        list{i,j} = dir(strcat(path, speakers{j}, emotions{i}));
    end
end

windowSize = 512;
overlap = windowSize/2;
numberOfCoefficients = 20;

for i = 1:size(list,1) 
    for j = 1:size(list,2)  %% We should optimize it for each element, property in the list in one for loop
        for k = 1:length(list{i,j})
            [audio, fs] = audioread(strcat(path, list{i,j}(k).name));
            list{i, j}(k).audioSignal = audio;
            list{i, j}(k).frequencySampling = fs;
            lpcCoeffs = lpcOnSingleAudio(audio, windowSize, overlap, numberOfCoefficients);
            list{i,j}(k).lpcCoeffs = lpcCoeffs;
            list{i,j}(k).mfcc = mfccOnSingleAudio(list{i,j}(k).audioSignal, fs, windowSize, overlap, 20);
           
        end
    end
end
    %% THE SPECTOGRAM for first file of anger
    [signal, fs] = audioread(strcat(path, list{1,1}(1).name));
    window = hamming(512); %size of window of analysis
    noverlap = 256; %number of repetition of window
    nfft = 1024; % size of frequency fourier transform (fft)
    spectrogram(signal,window,noverlap,nfft,fs,'yaxis');
    colormap('gray');
