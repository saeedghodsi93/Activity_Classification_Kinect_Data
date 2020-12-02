function [ average_accuracy,average_precision,average_recall ] = cross_validation(dataset_idx,cross_validation_idx,warping_window_size,signals,number_of_samples,action_length,skeleton_size,debug)
disp('Cross Validation...');

confusion_matrix=zeros(skeleton_size(3),skeleton_size(3)+1);

switch dataset_idx
    
    case {1,2,3,4,5,6}
        folderIdx=1:skeleton_size(1);
        for folder_idx=folderIdx
            trainFolderIdx=1:skeleton_size(1);
            testFolderIdx=folder_idx;
            trainFolderIdx(testFolderIdx)=[];
            display(trainFolderIdx);
            display(testFolderIdx);
            [train_signals_right_handed,train_signals_left_handed,train_labels_right_handed,train_labels_left_handed,train_lengths,test_signals,test_labels,test_lengths]=partition_CAD(trainFolderIdx,testFolderIdx,signals,action_length);
            train_labels = [train_labels_right_handed;train_labels_left_handed];
            active_subsignals_right_handed=feature_selection(train_signals_right_handed,train_labels_right_handed,train_lengths);
            active_subsignals_left_handed=feature_selection(train_signals_left_handed,train_labels_left_handed,train_lengths);
            tic;
            [template_signals_right_handed,template_lengths_right_handed] = create_templates(train_signals_right_handed,train_labels_right_handed,train_lengths,warping_window_size,debug);
            [template_signals_left_handed,template_lengths_left_handed] = create_templates(train_signals_left_handed,train_labels_left_handed,train_lengths,warping_window_size,debug);
            display(toc);
            tic;
            [train_warped_right_handed_right_handed,test_warped_right_handed] = temporal_warping(template_signals_right_handed,template_lengths_right_handed,train_signals_right_handed,train_lengths,test_signals,test_lengths,warping_window_size,debug);
            [train_warped_right_handed_left_handed,test_warped_left_handed] = temporal_warping(template_signals_left_handed,template_lengths_left_handed,train_signals_right_handed,train_lengths,test_signals,test_lengths,warping_window_size,debug);
            [train_warped_left_handed_right_handed,~] = temporal_warping(template_signals_right_handed,template_lengths_right_handed,train_signals_left_handed,train_lengths,test_signals,test_lengths,warping_window_size,debug);
            [train_warped_left_handed_left_handed,~] = temporal_warping(template_signals_left_handed,template_lengths_left_handed,train_signals_left_handed,train_lengths,test_signals,test_lengths,warping_window_size,debug);
            display(toc);
            tic;
%             [wavelet_name,wavelet_level] = parameter_tuning_CAD(template_lengths_right_handed,template_lengths_left_handed,train_warped_right_handed_right_handed,train_warped_right_handed_left_handed,train_warped_left_handed_right_handed,train_warped_left_handed_left_handed,active_subsignals_right_handed,active_subsignals_left_handed,train_labels_right_handed,train_labels_left_handed,debug);
            wavelet_name = 'db1';
            wavelet_level = 1;
            display(toc);
            tic;
            [train_features,test_features] = create_features_CAD(template_lengths_right_handed,template_lengths_left_handed,train_warped_right_handed_right_handed,train_warped_right_handed_left_handed,train_warped_left_handed_right_handed,train_warped_left_handed_left_handed,test_warped_right_handed,test_warped_left_handed,wavelet_name,wavelet_level,active_subsignals_right_handed,active_subsignals_left_handed,debug);
            display(toc);
            tic;
            confusion_matrix = classification(train_features,train_labels,test_features,test_labels,confusion_matrix);
            display(confusion_matrix);
            display(toc);
        end
        
    case {7,8,9,10,15}
        switch cross_validation_idx
            case 1
                folderIdx=1:skeleton_size(1);
                for folder_idx=folderIdx
                    trainFolderIdx=1:skeleton_size(1);
                    testFolderIdx=folder_idx;
                    trainFolderIdx(testFolderIdx)=[];
                    display(trainFolderIdx);
                    display(testFolderIdx);
                    [train_signals,train_labels,train_lengths,test_signals,test_labels,test_lengths]=partition(trainFolderIdx,testFolderIdx,signals,number_of_samples,action_length);
                    active_subsignals = feature_selection(train_signals,train_labels,train_lengths);
                    tic;
                    [template_signals,template_lengths] = create_templates(train_signals,train_labels,train_lengths,warping_window_size,debug);
                    display(toc);
                    tic;
                    [train_warped,test_warped] = temporal_warping(template_signals,template_lengths,train_signals,train_lengths,test_signals,test_lengths,warping_window_size,debug);
                    display(toc);
                    tic;
%                     [wavelet_name,wavelet_level] = parameter_tuning(template_lengths,train_warped,active_subsignals,train_labels,debug);
                    wavelet_name = 'db1';
                    wavelet_level = 1;
                    display(toc);
                    tic;
                    [train_features,test_features] = create_features(template_lengths,train_warped,test_warped,wavelet_name,wavelet_level,active_subsignals,debug);
                    display(toc);
                    tic;
                    size(train_features)
                    confusion_matrix = classification(train_features,train_labels,test_features,test_labels,confusion_matrix);
                    display(toc);
                end
                
            case 2
                K=2;
                folderIdx=randperm(skeleton_size(1));
                for k=1:K
                    trainFolderIdx=folderIdx(1:skeleton_size(1));
                    testFolderIdx=folderIdx((k-1)*floor(skeleton_size(1)/K)+1:k*floor(skeleton_size(1)/K));
                    trainFolderIdx((k-1)*floor(skeleton_size(1)/K)+1:k*floor(skeleton_size(1)/K))=[];
                    display(trainFolderIdx);
                    display(testFolderIdx);
                    [train_signals,train_labels,train_lengths,test_signals,test_labels,test_lengths]=partition(trainFolderIdx,testFolderIdx,signals,number_of_samples,action_length);
                    active_subsignals = feature_selection(train_signals,train_labels,train_lengths);
                    tic;
                    [template_signals,template_lengths] = create_templates(train_signals,train_labels,train_lengths,warping_window_size,debug);
                    display(toc);
                    tic;
                    [train_warped,test_warped] = temporal_warping(template_signals,template_lengths,train_signals,train_lengths,test_signals,test_lengths,warping_window_size,debug);
                    display(toc);
                    tic;
%                     [wavelet_name,wavelet_level] = parameter_tuning(template_lengths,train_warped,active_subsignals,train_labels,debug);
                    wavelet_name = 'db1';
                    wavelet_level = 1;
                    display(toc);
                    tic;
                    [train_features,test_features] = create_features(template_lengths,train_warped,test_warped,wavelet_name,wavelet_level,active_subsignals,debug);
                    display(toc);
                    tic;
                    confusion_matrix = classification(train_features,train_labels,test_features,test_labels,confusion_matrix);
                    display(toc);
                end
                
            case 3
                K=4;
                folderIdx=randperm(skeleton_size(1));
                for k=1:K
                    trainFolderIdx=folderIdx(1:skeleton_size(1));
                    testFolderIdx=folderIdx((k-1)*floor(skeleton_size(1)/K)+1:k*floor(skeleton_size(1)/K));
                    trainFolderIdx((k-1)*floor(skeleton_size(1)/K)+1:k*floor(skeleton_size(1)/K))=[];
                    display(trainFolderIdx);
                    display(testFolderIdx);
                    [train_signals,train_labels,train_lengths,test_signals,test_labels,test_lengths]=partition(trainFolderIdx,testFolderIdx,signals,number_of_samples,action_length);
                    active_subsignals = feature_selection(train_signals,train_labels,train_lengths);
                    tic;
                    [template_signals,template_lengths] = create_templates(train_signals,train_labels,train_lengths,warping_window_size,debug);
                    display(toc);
                    tic;
                    [train_warped,test_warped] = temporal_warping(template_signals,template_lengths,train_signals,train_lengths,test_signals,test_lengths,warping_window_size,debug);
                    display(toc);
                    tic;
%                     [wavelet_name,wavelet_level] = parameter_tuning(template_lengths,train_warped,active_subsignals,train_labels,debug);
                    wavelet_name = 'db1';
                    wavelet_level = 1;
                    display(toc);
                    tic;
                    [train_features,test_features] = create_features(template_lengths,train_warped,test_warped,wavelet_name,wavelet_level,active_subsignals,debug);
                    display(toc);
                    tic;
                    confusion_matrix = classification(train_features,train_labels,test_features,test_labels,confusion_matrix);
                    display(toc);
                end
                
        end
        
    case {11,12,13,14}
        trainFolderIdx=[1 3 5 7 9];
        testFolderIdx=[2 4 6 8 10];
        display(trainFolderIdx);
        display(testFolderIdx);
        [train_signals,train_labels,train_lengths,test_signals,test_labels,test_lengths]=partition(trainFolderIdx,testFolderIdx,signals,number_of_samples,action_length);
        active_subsignals=feature_selection(train_signals,train_labels,train_lengths);
        tic;
        [template_signals,template_lengths] = create_templates(train_signals,train_labels,train_lengths,warping_window_size,debug);
        display(toc);
        tic;
        [train_warped,test_warped] = temporal_warping(template_signals,template_lengths,train_signals,train_lengths,test_signals,test_lengths,warping_window_size,debug);
        display(toc);
        tic;
        [wavelet_name,wavelet_level] = parameter_tuning(template_lengths,train_warped,active_subsignals,train_labels,debug);
        display(toc);
        tic;
        [train_features,test_features] = create_features(template_lengths,train_warped,test_warped,wavelet_name,wavelet_level,active_subsignals,debug);
        display(toc);
        tic;
        confusion_matrix = classification(train_features,train_labels,test_features,test_labels,confusion_matrix);
        display(toc);
        
    case 16
        folderIdx=1:skeleton_size(1);
        for folder_idx=folderIdx
            trainFolderIdx=1:skeleton_size(1);
            testFolderIdx=folder_idx;
            trainFolderIdx(testFolderIdx)=[];
            display(trainFolderIdx);
            display(testFolderIdx);
            [train_signals,train_labels,train_lengths,test_signals,test_labels,test_lengths]=partition(trainFolderIdx,testFolderIdx,signals,number_of_samples,action_length);
            active_subsignals=feature_selection(train_signals,train_labels,train_lengths);
            tic;
            [template_signals,template_lengths] = create_templates(train_signals,train_labels,train_lengths,warping_window_size,debug);
            display(toc);
            tic;
            [train_warped,test_warped] = temporal_warping(template_signals,template_lengths,train_signals,train_lengths,test_signals,test_lengths,warping_window_size,debug);
            display(toc);
            tic;
%             [wavelet_name,wavelet_level] = parameter_tuning(template_lengths,train_warped,active_subsignals,train_labels,debug);
            wavelet_name = 'db1';
            wavelet_level = 1;
            display(toc);
            tic;
            [train_features,test_features] = create_features(template_lengths,train_warped,test_warped,wavelet_name,wavelet_level,active_subsignals,debug);
            display(toc);
            tic;
            confusion_matrix = classification(train_features,train_labels,test_features,test_labels,confusion_matrix);
            display(confusion_matrix);
            display(toc);
        end

end

[average_accuracy,average_precision,average_recall]=result(confusion_matrix,dataset_idx,cross_validation_idx);

end
