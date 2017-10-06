class = net(samples);
[~, class] = max(class, [], 1);
[~, labels] = max(labels, [], 1);
acc = class==labels;
acc = sum(acc) / length(acc)