function trainLabel = load_train_label_high_level(folderIndex)
trainLabel = zeros([] , 1);
testIndex = 1: 3;
activityIndex = 1: 10;
counter = 1;
for folder_index = folderIndex
    for test_index = testIndex
        for activity_index = activityIndex
            trainLabel(counter , 1) = activity_index;
            counter = counter + 1;
        end
    end
end
end