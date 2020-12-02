function [ active_subsignals ] = feature_selection( train_signals,train_labels,train_lengths )
    disp('	Feature Selection...');
    
    subsignals_displacement=zeros(max(train_labels),size(train_signals,2),[]);
    number=zeros(max(train_labels),1);
    for sample_idx = 1:size(train_signals,1)
        number(train_labels(sample_idx,1),1) = number(train_labels(sample_idx,1),1) + 1;
        for subsignal_idx=1:size(train_signals,2)
            dis=0;
            for frame_idx = 1:train_lengths(sample_idx,1)-1
                dis = dis + abs(train_signals(sample_idx,subsignal_idx,frame_idx+1)-train_signals(sample_idx,subsignal_idx,frame_idx));
            end
            subsignals_displacement(train_labels(sample_idx,1),subsignal_idx,number(train_labels(sample_idx,1),1)) = dis;
        end
    end
    
    active_subsignals=zeros(size(subsignals_displacement,1),size(subsignals_displacement,2));
    for action_idx = 1:size(subsignals_displacement,1)
        for subsignal_idx=1:size(subsignals_displacement,2)
            if median(subsignals_displacement(action_idx,subsignal_idx,1:number(action_idx,1)))>50
                active_subsignals(action_idx,subsignal_idx) = 1;
            end
%             active_subsignals(action_idx,subsignal_idx) = median(subsignals_displacement(action_idx,1:number(action_idx,1),subsignal_idx));
        end
    end
%     display(active_subsignals);

%     for action_idx = 1:size(subsignals_displacement,1)
%         [s,i] = sort(active_subsignals(action_idx,:));
%         display(i);
%     end
    
    % Set all subsignals as active
    for action_idx = 1:size(subsignals_displacement,1)
        for subsignal_idx=1:size(subsignals_displacement,2)
            active_subsignals(action_idx,subsignal_idx) = 1;
        end
    end
end
