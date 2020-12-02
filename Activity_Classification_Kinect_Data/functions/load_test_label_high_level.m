function testLabel = load_test_label_high_level(folderIndex)
testLabel = zeros([] , 1);
testIndex = 1: 3;
activityIndex = 1: 10;
counter = 1;
for folder_index = folderIndex
    for test_index = testIndex
        for activity_index = activityIndex
            testLabel(counter , 1) = activity_index;
            counter = counter + 1;
        end
    end
end
end