function trainLength = load_train_length_high_level(folderIndex ,action_length)
trainLength = zeros([] , 1);
testIndex = 1:3;
activityIndex = 1: 10;
counter = 1;
for folder_index = folderIndex
    for test_index = testIndex
        for activity_index = activityIndex
            trainLength(counter , 1) = action_length(folder_index , test_index ,activity_index);
            counter = counter + 1;
        end
    end
end
end