function [ best_wavelet_name, best_wavelet_level ] = parameter_tuning( template_lengths,train_warped,active_subsignals,train_labels,debug )
disp('	Parameter Tuning...');

tuningWaveletName = {'db1'};
tuningWaveletLevel = [1,3,5];

number_of_actions = max(train_labels);
number_of_subjects = size(train_labels,1)/number_of_actions;

train_warped = reshape(train_warped,number_of_subjects,number_of_actions,size(train_warped,2),size(train_warped,3),size(train_warped,4));
train_labels = reshape(train_labels,number_of_subjects,number_of_actions,size(train_labels,2));

best_accuracy = 0;
for tuning_wavelet_name_cell=tuningWaveletName
    tuning_wavelet_name = tuning_wavelet_name_cell{1};
    for tuning_wavelet_level=tuningWaveletLevel
        tuning_confusion_matrix=zeros(number_of_actions,number_of_actions);
        
        K=2;
        folderIdx=randperm(size(train_warped,1));
        for k=1:K
            trainFolderIdx=folderIdx(1:size(train_warped,1));
            testFolderIdx=folderIdx((k-1)*floor(size(train_warped,1)/K)+1:k*floor(size(train_warped,1)/K));
            trainFolderIdx((k-1)*floor(size(train_warped,1)/K)+1:k*floor(size(train_warped,1)/K))=[];
            
            tuning_train_warped = train_warped(trainFolderIdx,:,:,:,:);
            tuning_test_warped = train_warped(testFolderIdx,:,:,:,:);
            
            tuning_train_warped = reshape(tuning_train_warped,size(tuning_train_warped,1)*size(tuning_train_warped,2),size(tuning_train_warped,3),size(tuning_train_warped,4),size(tuning_train_warped,5));
            tuning_test_warped = reshape(tuning_test_warped,size(tuning_test_warped,1)*size(tuning_test_warped,2),size(tuning_test_warped,3),size(tuning_test_warped,4),size(tuning_test_warped,5));
            
            tuning_train_labels = train_labels(trainFolderIdx,:);
            tuning_test_labels = train_labels(testFolderIdx,:);
            
            tuning_train_labels = reshape(tuning_train_labels,size(tuning_train_labels,1)*size(tuning_train_labels,2),1);
            tuning_test_labels = reshape(tuning_test_labels,size(tuning_test_labels,1)*size(tuning_test_labels,2),1);
            
            [tuning_train_features,tuning_test_features] = create_features(template_lengths,tuning_train_warped,tuning_test_warped,tuning_wavelet_name,tuning_wavelet_level,active_subsignals,debug);
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
        
    end
end
display(best_accuracy);
display(best_wavelet_name);
display(best_wavelet_level);

end
