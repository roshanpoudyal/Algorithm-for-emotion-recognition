function max_array = mymax(label)
edges=unique(label);
counts=hist(label(:),length(edges));
[~, max_array] = max(counts);
max_array = edges(max_array);
end
