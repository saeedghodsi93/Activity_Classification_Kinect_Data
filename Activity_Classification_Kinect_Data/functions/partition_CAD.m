function [ train_signals_right_handed,train_signals_left_handed,train_labels_right_handed,train_labels_left_handed,train_lengths,test_signals,test_labels,test_lengths ] = partition_CAD( trainFolderIdx,testFolderIdx,signals,action_length )
    disp('	Partition...');    
    
    number_of_actions=size(signals,3);
    
%% features and labels for train step
    
    % right handed observations
    observations=zeros(number_of_actions,[],size(signals,4),size(signals,5));
    number=0;
    for folder_idx = trainFolderIdx
        if folder_idx==1 || folder_idx==2 || folder_idx==4
            test_offset = 0;
        else
            test_offset = size(signals,2)/2;
        end    
        for test_idx = 1+test_offset:size(signals,2)/2+test_offset
            number=number+1; % sample number
            for action_idx = 1:size(signals,3)
                observations(action_idx,number,:,:)=signals(folder_idx,test_idx,action_idx,:,:);
            end
        end
    end
    
    labels=zeros(size(observations,1)*size(observations,2),1);
    for i=1:size(observations,1)
        labels((i-1)*size(observations,2)+1:i*size(observations,2),1)=i;
    end
    train_labels_right_handed=labels;
    
    observations=permute(observations,[4 3 2 1]);
    observations=reshape(observations,size(observations,1),size(observations,2),size(observations,3)*size(observations,4));
    observations=permute(observations,[3 2 1]);
    train_signals_right_handed=observations;
    
    % left handed observations
    observations=zeros(number_of_actions,[],size(signals,4),size(signals,5));
    number=0;
    for folder_idx = trainFolderIdx
        if folder_idx==1 || folder_idx==2 || folder_idx==4
            test_offset = size(signals,2)/2;
        else
            test_offset = 0;
        end
        for test_idx = 1+test_offset:size(signals,2)/2+test_offset
            number=number+1; % sample number
            for action_idx = 1:size(signals,3)
                observations(action_idx,number,:,:)=signals(folder_idx,test_idx,action_idx,:,:);
            end
        end
    end
    
    labels=zeros(size(observations,1)*size(observations,2),1);
    for i=1:size(observations,1)
        labels((i-1)*size(observations,2)+1:i*size(observations,2),1)=i;
    end
    train_labels_left_handed=labels;
    
    observations=permute(observations,[4 3 2 1]);
    observations=reshape(observations,size(observations,1),size(observations,2),size(observations,3)*size(observations,4));
    observations=permute(observations,[3 2 1]);
    train_signals_left_handed=observations;
    
    % lengths
    lengths=zeros(number_of_actions,[]);
    number=0;
    for folder_idx = trainFolderIdx
        for test_idx = 1:size(signals,2)/2
            number=number+1; % sample number
            for action_idx = 1:size(signals,3)
                lengths(action_idx,number)=action_length(folder_idx,test_idx,action_idx);
            end
        end
    end
    lengths=reshape(lengths',size(lengths,1)*size(lengths,2),1);
    train_lengths=lengths;
    
%% features and labels for test step
    
    observations=zeros(number_of_actions,[],size(signals,4),size(signals,5));
    lengths=zeros(number_of_actions,[]);
    number=0;
    for folder_idx = testFolderIdx    
        for test_idx = 1:size(signals,2)/2
            number=number+1; % sample number
            for action_idx = 1:size(signals,3)
                observations(action_idx,number,:,:)=signals(folder_idx,test_idx,action_idx,:,:);
                lengths(action_idx,number)=action_length(folder_idx,test_idx,action_idx);
            end
        end
    end
    
    labels=zeros(size(observations,1)*size(observations,2),1);
    for i=1:size(observations,1)
        labels((i-1)*size(observations,2)+1:i*size(observations,2),1)=i;
    end
        
    observations=permute(observations,[4 3 2 1]);
    observations=reshape(observations,size(observations,1),size(observations,2),size(observations,3)*size(observations,4));
    observations=permute(observations,[3 2 1]);
    
    lengths=reshape(lengths',size(lengths,1)*size(lengths,2),1);

    % assign features and labels to output
    test_signals=observations;
    test_labels=labels;
    test_lengths=lengths;
    
end
