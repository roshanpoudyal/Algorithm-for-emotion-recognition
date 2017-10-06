[trainingSamples, labels] = createSamplingMatrixMFCC(list, 1);
[trainingSamples2, labels2] = createSamplingMatrixMFCC(list, 2);
[trainingSamples3, labels3] = createSamplingMatrixMFCC(list, 3);
[trainingSamples4, labels4] = createSamplingMatrixMFCC(list, 4);
[trainingSamples5, labels5] = createSamplingMatrixMFCC(list, 5);
[trainingSamples6, labels6] = createSamplingMatrixMFCC(list, 6);
[trainingSamples7, labels7] = createSamplingMatrixMFCC(list, 7);
trainingSamples = cat(1, trainingSamples, trainingSamples2, trainingSamples3, trainingSamples4, trainingSamples5, trainingSamples6, trainingSamples7);
labels = cat(1, labels, labels2, labels3, labels4, labels5, labels6, labels7);

[testSamples, labelsTest] = createSamplingMatrixMFCC(list, 8);
[testSamples2, labelsTest2] = createSamplingMatrixMFCC(list, 9);
[testSamples3, labelsTest3] = createSamplingMatrixMFCC(list, 10);
clearvars trainingSamples2 trainingSamples3 trainingSamples4 trainingSamples5 trainingSamples6 trainingSamples7
clearvars labels2 labels3 labels4 labels5 labels6 labels7


testSamples = cat(1, testSamples, testSamples2, testSamples3);
labelsTest = cat(1, labelsTest, labelsTest2, labelsTest3);

clearvars testSamples2 testSamples3
clearvars labelsTest2 labelsTest3

net = patternnet(10);
net = train(net,trainingSamples',labels');
view(net)
class = net(testSamples');
class = round(class);

accuracy = zeros(length(class),1);
for i = 1:length(class)
    str1 = class(i);
    str2 = labelsTest(i);
    accuracy(i) = str1==str2;
end
accuracy = sum(accuracy, 1) / length(accuracy);