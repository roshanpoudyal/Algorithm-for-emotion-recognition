function matrix = lpcOnSingleAudio(audioSignal, windowSize, overlap, numberOfCoefficients)
i = 1;
matrix = [];

while i+windowSize-1<=length(audioSignal)
    aud = audioSignal(i: i+windowSize-1);
    if(sum(aud)>0)
        i = i + overlap;
        continue;
    end
    [sortedAud, indices] = sort(aud, 'ascend');
    chopped = round(length(sortedAud)*0.5);
    indices = indices(1:chopped);
    aud(indices) = [];
    arr = lpc(aud, numberOfCoefficients);
    
    matrix = cat(2, matrix, arr');
    i = i + overlap;
end
% matrix = matrix';
% avg = sum(matrix.^2)./size(matrix,1);
% avg = sum(matrix.^2,2);
% [avg, indices] = sort(avg, 'ascend');
% chopped = round(length(avg)*0.1);
% indices = indices(1:chopped);
% matrix(:, indices) = [];
% avg = avg(chopped+1:end);

end