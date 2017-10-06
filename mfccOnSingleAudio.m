function matrix = mfccOnSingleAudio(audioSignal, fs, windowSize, overlap, numberOfCoefficients)
    
    
%     [~, indices] = sort(z, 'ascend');
%     chopped = round(length(z)*0.10);
%     indices = indices(chopped+1:end);
%     z = z(indices);
    
    
    i = 1;
    matrix = [];
    
    
    while i+windowSize-1<=length(audioSignal)
        aud = audioSignal(i: i+windowSize-1);
        [sortedAud, indices] = sort(aud, 'ascend');
        chopped = round(length(sortedAud)*0.1);
        indices = indices(1:chopped);
        aud(indices) = [];
        p = 1;
        n= windowSize;
        f=fft(aud);
        % n is the fft length, p is the number of filters wanted
        [x,mc,na,nb]=melbankm(p,n,fs);   % na:nb gives the fft bins that are needed
        nb = min(length(f), nb);
        if nb < length(x)
            x(nb:end) = [];
        end
        z=log(x*(f(na:nb)).*conj(f(na:nb)));
        interval = length(z)/numberOfCoefficients;
        z = abs(z(1:interval:end));
%         [~, indices] = sort(z, 'ascend');
%         chopped = round(length(z)*0.10);
%         indices = indices(chopped+1:end);
%         z = z(indices);
        
        if(sum(isnan(z))>0)
            i = i + overlap;
            continue;
        end
        matrix = cat(2, matrix, z);
        i = i + overlap;
    end

end