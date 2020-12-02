function trainSignal = load_train_signal_high_level(folderIndex , positions , action_length)

trainSignal = zeros([] ,max(max(max(max(action_length)))),size(positions,5));
activityIndex = 1 : 10;
testIndex = 1:3;

counter = 1;

for folder_index = folderIndex
    for test_index = testIndex
        for activity_index = activityIndex
            for frame_index = 1 : action_length(folder_index , test_index , activity_index)
                for i = 1 : size(positions , 5)
                    trainSignal(counter ,frame_index ,i) = positions(folder_index ,test_index ,activity_index ,frame_index , i);
                end
            end
            counter = counter + 1 ;
        end
    end
end
end