function [ train_signals,train_labels,train_lengths,test_signals,test_labels,test_lengths ] = partition( trainFolderIdx,testFolderIdx,signals,number_of_samples,action_length )
    disp('	Partition...');    
    
%% features and labels for train step
    
    observations=zeros([],size(signals,4),size(signals,5));
    lengths=zeros([],1);
    labels=zeros([],1);
    subject_idx=0;
    for folder_idx = trainFolderIdx
        subject_idx=subject_idx+1;
        for action_idx = 1:size(signals,3)
            for test_idx = 1:number_of_samples(folder_idx,action_idx)
                idx=sum(sum(number_of_samples(trainFolderIdx,1:action_idx-1)))+sum(number_of_samples(trainFolderIdx(1:subject_idx-1),action_idx))+test_idx;
                observations(idx,:,:)=signals(folder_idx,test_idx,action_idx,:,:);
                lengths(idx,1)=action_length(folder_idx,test_idx,action_idx);
                labels(idx,1)=action_idx;
            end
        end
    end
    
    % assign features and labels to output
    train_signals=observations;
    train_labels=labels;
    train_lengths=lengths;
    
%% features and labels for test step
    
    observations=zeros([],size(signals,4),size(signals,5));
    lengths=zeros([],1);
    labels=zeros([],1);
    subject_idx=0;
    for folder_idx = testFolderIdx
        subject_idx=subject_idx+1;
        for action_idx = 1:size(signals,3)
            for test_idx = 1:number_of_samples(folder_idx,action_idx)
                idx=sum(sum(number_of_samples(testFolderIdx,1:action_idx-1)))+sum(number_of_samples(testFolderIdx(1:subject_idx-1),action_idx))+test_idx;
                observations(idx,:,:)=signals(folder_idx,test_idx,action_idx,:,:);
                lengths(idx,1)=action_length(folder_idx,test_idx,action_idx);
                labels(idx,1)=action_idx;
            end
        end
    end
    
    % assign features and labels to output
    test_signals=observations;
    test_labels=labels;
    test_lengths=lengths;
    
end
