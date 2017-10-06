[trainingSamples, labels] = createSamplingMatrix(list, 1);
[trainingSamples2, labels2] = createSamplingMatrix(list, 2);
[trainingSamples3, labels3] = createSamplingMatrix(list, 3);
[trainingSamples4, labels4] = createSamplingMatrix(list, 4);
[trainingSamples5, labels5] = createSamplingMatrix(list, 5);
[trainingSamples6, labels6] = createSamplingMatrix(list, 6);
[trainingSamples7, labels7] = createSamplingMatrix(list, 7);
trainingSamples = cat(1, trainingSamples, trainingSamples2, trainingSamples3, trainingSamples4, trainingSamples5, trainingSamples6, trainingSamples7);
labels = cat(1, labels, labels2, labels3, labels4, labels5, labels6, labels7);

[testSamples, labelsTest] = createSamplingMatrix(list, 8);
[testSamples2, labelsTest2] = createSamplingMatrix(list, 9);
[testSamples3, labelsTest3] = createSamplingMatrix(list, 10);

testSamples = cat(1, testSamples, testSamples2, testSamples3);
labelsTest = cat(1, labelsTest, labelsTest2, labelsTest3);
class = knnclassify(testSamples, trainingSamples, labels, 5);


error = zeros(length(class),1);
for i = 1:length(class)
    str1 = class{i};
    str2 = labelsTest{i};
    error(i) = strcmp(str1, str2);
end
accuracy = sum(error, 1) / length(error);