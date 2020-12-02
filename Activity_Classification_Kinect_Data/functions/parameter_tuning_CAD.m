function [ best_wavelet_name, best_wavelet_level ] = parameter_tuning_CAD( template_lengths_right_handed,template_lengths_left_handed,train_warped_right_handed_right_handed,train_warped_right_handed_left_handed,train_warped_left_handed_right_handed,train_warped_left_handed_left_handed,active_subsignals_right_handed,active_subsignals_left_handed,train_labels_right_handed,train_labels_left_handed,debug )
    disp('	Parameter Tuning...');
    
    tuningWaveletName = {'db1','sym2'};
    tuningWaveletLevel = [1,3,5];
    
    number_of_actions = max(train_labels_right_handed);
    number_of_subjects = size(train_labels_right_handed,1)/number_of_actions;
    
    train_warped_right_handed_right_handed = reshape(train_warped_right_handed_right_handed,number_of_subjects,number_of_actions,size(train_warped_right_handed_right_handed,2),size(train_warped_right_handed_right_handed,3),size(train_warped_right_handed_right_handed,4));
    train_warped_right_handed_left_handed = reshape(train_warped_right_handed_left_handed,number_of_subjects,number_of_actions,size(train_warped_right_handed_left_handed,2),size(train_warped_right_handed_left_handed,3),size(train_warped_right_handed_left_handed,4));
    train_warped_left_handed_right_handed = reshape(train_warped_left_handed_right_handed,number_of_subjects,number_of_actions,size(train_warped_left_handed_right_handed,2),size(train_warped_left_handed_right_handed,3),size(train_warped_left_handed_right_handed,4));
    train_warped_left_handed_left_handed = reshape(train_warped_left_handed_left_handed,number_of_subjects,number_of_actions,size(train_warped_left_handed_left_handed,2),size(train_warped_left_handed_left_handed,3),size(train_warped_left_handed_left_handed,4));

    train_labels_right_handed = reshape(train_labels_right_handed,number_of_subjects,number_of_actions,size(train_labels_right_handed,2));
    train_labels_left_handed = reshape(train_labels_left_handed,number_of_subjects,number_of_actions,size(train_labels_left_handed,2));
            
    best_accuracy = 0;
    for tuning_wavelet_name_cell=tuningWaveletName
        tuning_wavelet_name = tuning_wavelet_name_cell{1};
        for tuning_wavelet_level=tuningWaveletLevel
            
            tuning_confusion_matrix=zeros(number_of_actions,number_of_actions);
            
            folderIdx=1:size(train_warped_right_handed_right_handed,1);
            for folder_idx=folderIdx
                trainFolderIdx=1:size(train_warped_right_handed_right_handed,1);
                testFolderIdx=folder_idx;
                trainFolderIdx(testFolderIdx)=[];
                
                tuning_train_warped_right_handed_right_handed = train_warped_right_handed_right_handed(trainFolderIdx,:,:,:,:);
                tuning_train_warped_right_handed_left_handed = train_warped_right_handed_left_handed(trainFolderIdx,:,:,:,:);
                tuning_train_warped_left_handed_right_handed = train_warped_left_handed_right_handed(trainFolderIdx,:,:,:,:);
                tuning_train_warped_left_handed_left_handed = train_warped_left_handed_left_handed(trainFolderIdx,:,:,:,:);
                tuning_test_warped_right_handed_right_handed = train_warped_right_handed_right_handed(testFolderIdx,:,:,:,:);
                tuning_test_warped_right_handed_left_handed = train_warped_right_handed_left_handed(testFolderIdx,:,:,:,:);
                tuning_test_warped_left_handed_right_handed = train_warped_left_handed_right_handed(testFolderIdx,:,:,:,:);
                tuning_test_warped_left_handed_left_handed = train_warped_left_handed_left_handed(testFolderIdx,:,:,:,:);
                
                tuning_train_warped_right_handed_right_handed = reshape(tuning_train_warped_right_handed_right_handed,size(tuning_train_warped_right_handed_right_handed,1)*size(tuning_train_warped_right_handed_right_handed,2),size(tuning_train_warped_right_handed_right_handed,3),size(tuning_train_warped_right_handed_right_handed,4),size(tuning_train_warped_right_handed_right_handed,5));
                tuning_train_warped_right_handed_left_handed = reshape(tuning_train_warped_right_handed_left_handed,size(tuning_train_warped_right_handed_left_handed,1)*size(tuning_train_warped_right_handed_left_handed,2),size(tuning_train_warped_right_handed_left_handed,3),size(tuning_train_warped_right_handed_left_handed,4),size(tuning_train_warped_right_handed_left_handed,5));
                tuning_train_warped_left_handed_right_handed = reshape(tuning_train_warped_left_handed_right_handed,size(tuning_train_warped_left_handed_right_handed,1)*size(tuning_train_warped_left_handed_right_handed,2),size(tuning_train_warped_left_handed_right_handed,3),size(tuning_train_warped_left_handed_right_handed,4),size(tuning_train_warped_left_handed_right_handed,5));
                tuning_train_warped_left_handed_left_handed = reshape(tuning_train_warped_left_handed_left_handed,size(tuning_train_warped_left_handed_left_handed,1)*size(tuning_train_warped_left_handed_left_handed,2),size(tuning_train_warped_left_handed_left_handed,3),size(tuning_train_warped_left_handed_left_handed,4),size(tuning_train_warped_left_handed_left_handed,5));
                tuning_test_warped_right_handed_right_handed = reshape(tuning_test_warped_right_handed_right_handed,size(tuning_test_warped_right_handed_right_handed,1)*size(tuning_test_warped_right_handed_right_handed,2),size(tuning_test_warped_right_handed_right_handed,3),size(tuning_test_warped_right_handed_right_handed,4),size(tuning_test_warped_right_handed_right_handed,5));
                tuning_test_warped_right_handed_left_handed = reshape(tuning_test_warped_right_handed_left_handed,size(tuning_test_warped_right_handed_left_handed,1)*size(tuning_test_warped_right_handed_left_handed,2),size(tuning_test_warped_right_handed_left_handed,3),size(tuning_test_warped_right_handed_left_handed,4),size(tuning_test_warped_right_handed_left_handed,5));
                tuning_test_warped_left_handed_right_handed = reshape(tuning_test_warped_left_handed_right_handed,size(tuning_test_warped_left_handed_right_handed,1)*size(tuning_test_warped_left_handed_right_handed,2),size(tuning_test_warped_left_handed_right_handed,3),size(tuning_test_warped_left_handed_right_handed,4),size(tuning_test_warped_left_handed_right_handed,5));
                tuning_test_warped_left_handed_left_handed = reshape(tuning_test_warped_left_handed_left_handed,size(tuning_test_warped_left_handed_left_handed,1)*size(tuning_test_warped_left_handed_left_handed,2),size(tuning_test_warped_left_handed_left_handed,3),size(tuning_test_warped_left_handed_left_handed,4),size(tuning_test_warped_left_handed_left_handed,5));

                tuning_test_warped_right_handed = cat(1,tuning_test_warped_right_handed_right_handed,tuning_test_warped_left_handed_right_handed);
                tuning_test_warped_left_handed = cat(1,tuning_test_warped_right_handed_left_handed,tuning_test_warped_left_handed_left_handed);
                
                tuning_train_labels_right_handed = train_labels_right_handed(trainFolderIdx,:);
                tuning_train_labels_left_handed = train_labels_left_handed(trainFolderIdx,:);
                tuning_test_labels_right_handed = train_labels_right_handed(testFolderIdx,:);
                tuning_test_labels_left_handed = train_labels_left_handed(testFolderIdx,:);
                
                tuning_train_labels_right_handed = reshape(tuning_train_labels_right_handed,size(tuning_train_labels_right_handed,1)*size(tuning_train_labels_right_handed,2),1);
                tuning_train_labels_left_handed = reshape(tuning_train_labels_left_handed,size(tuning_train_labels_left_handed,1)*size(tuning_train_labels_left_handed,2),1);
                tuning_test_labels_right_handed = reshape(tuning_test_labels_right_handed,size(tuning_test_labels_right_handed,1)*size(tuning_test_labels_right_handed,2),1);
                tuning_test_labels_left_handed = reshape(tuning_test_labels_left_handed,size(tuning_test_labels_left_handed,1)*size(tuning_test_labels_left_handed,2),1);
                
                tuning_train_labels = [tuning_train_labels_right_handed;tuning_train_labels_left_handed];
                tuning_test_labels = [tuning_test_labels_right_handed;tuning_test_labels_left_handed];
                
                [tuning_train_features,tuning_test_features] = create_features_CAD(template_lengths_right_handed,template_lengths_left_handed,tuning_train_warped_right_handed_right_handed,tuning_train_warped_right_handed_left_handed,tuning_train_warped_left_handed_right_handed,tuning_train_warped_left_handed_left_handed,tuning_test_warped_right_handed,tuning_test_warped_left_handed,tuning_wavelet_name,tuning_wavelet_level,active_subsignals_right_handed,active_subsignals_left_handed,debug);
                tuning_confusion_matrix = classification(tuning_train_features,tuning_train_labels,tuning_test_features,tuning_test_labels,tuning_confusion_matrix);

            end

            tuning_average_accuracy = 0;
            for i=1:size(tuning_confusion_matrix,1)
                tuning_average_accuracy = tuning_average_accuracy + tuning_confusion_matrix(i,i);
            end
            tuning_average_accuracy = tuning_average_accuracy / sum(sum(tuning_confusion_matrix));
            
            if best_accuracy<=tuning_average_accuracy
                best_accuracy = tuning_average_accuracy;
                best_wavelet_name = tuning_wavelet_name;
                best_wavelet_level = tuning_wavelet_level;
            end
            display(tuning_average_accuracy);
            
        end
    end
    display(best_accuracy);
    display(best_wavelet_name);
    display(best_wavelet_level);
    
end
