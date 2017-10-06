function S = upsampleMatrix(samples, n)
    S = samples;
    if(n>size(samples,1))
        num = n - size(samples,2);
        indices = [];
        for i = 1:num
            indices = cat(2, indices, randperm(size(samples,1), 1));
        end
        extraSamples = samples(:, indices);
        S = cat(2, S, extraSamples);
    end        
end


% function [S, L] = upsampleMatrix(samples, labels, n)
%     S = samples;
%     L = labels;
%     if(n>size(samples,1))
%         num = n - size(samples,1);
%         indices = [];
%         for i = 1:num
%             indices = cat(2, indices, randperm(size(samples,1), 1));
%         end
%         extraSamples = samples(indices, :);
%         extraLabels = labels(indices);
%         S = cat(1, S, extraSamples);
%         L = cat(1, L, extraLabels);    
%     end        
% end