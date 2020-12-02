function [ template_signals,template_lengths ] = create_templates( train_signals,train_labels,train_lengths,warping_window_size,debug )
    disp('	Creating Templates...');
    
    actions = zeros(max(train_labels),[],size(train_signals,2),size(train_signals,3));
    lengths = zeros(max(train_labels),[]);
    observations_counter = zeros(max(train_labels),1);
    for i=1:size(train_signals,1)
        observations_counter(train_labels(i),1) = observations_counter(train_labels(i),1)+1;
        actions(train_labels(i),observations_counter(train_labels(i)),:,:) = train_signals(i,:,:);
        lengths(train_labels(i),observations_counter(train_labels(i))) = train_lengths(i);
    end
    
    number_of_actions = size(actions,1);
    number_of_subsignals = size(actions,3);
    mean_subsignals = zeros(size(actions,1),number_of_subsignals);
    parfor subsignal_idx=1:number_of_subsignals
        for action_idx=1:number_of_actions
            distances = zeros(observations_counter(action_idx,1),1);
            for i=1:observations_counter(action_idx,1)
                for j=1:observations_counter(action_idx,1)
                    x_length = lengths(action_idx,i);
                    y_length = lengths(action_idx,j);
                    x_subsignal = permute(actions(action_idx,i,subsignal_idx,1:x_length),[3 4 1 2]);
                    y_subsignal = permute(actions(action_idx,j,subsignal_idx,1:y_length),[3 4 1 2]);
                    window_size = max([abs(x_length-y_length),ceil(warping_window_size*max([x_length,y_length]))]);
                    distances(i,1) = distances(i,1) + dtw(x_subsignal,y_subsignal,window_size);
                end
            end
            [~,idx] = min(distances);
            mean_subsignals(action_idx,subsignal_idx) = idx;
        end
    end
    
%     for action_idx=1:number_of_actions
%         display(action_idx);
%         for subsignal_idx=1:number_of_subsignals
%             display(subsignal_idx);
%             display(mean_subsignals(action_idx,subsignal_idx));
%             x_length = lengths(action_idx,mean_subsignals(action_idx,subsignal_idx));
%             x_subsignal = permute(actions(action_idx,mean_subsignals(action_idx,subsignal_idx),subsignal_idx,1:x_length),[3 4 1 2]);
%             for i=1:size(actions,2)
%                 y_length = lengths(action_idx,i);
%                 y_subsignal = permute(actions(action_idx,i,subsignal_idx,1:y_length),[3 4 1 2]);
%                 window_size = max([abs(x_length-y_length),ceil(warping_window_size*max([x_length,y_length]))]);
%                 display(dtw(x_subsignal,y_subsignal,window_size));
%             end
%         end
%     end
    
    actions_warped = zeros(size(actions,1),size(actions,2),number_of_subsignals,size(train_signals,3));
    for subsignal_idx=1:number_of_subsignals
        for action_idx=1:number_of_actions
            x_length = lengths(action_idx,mean_subsignals(action_idx,subsignal_idx));
            x_subsignal = permute(actions(action_idx,mean_subsignals(action_idx,subsignal_idx),subsignal_idx,1:x_length),[3 4 1 2]);
            for i=1:observations_counter(action_idx,1)
                y_length = lengths(action_idx,i);
                y_subsignal = permute(actions(action_idx,i,subsignal_idx,1:y_length),[3 4 1 2]);
                window_size = max([abs(x_length-y_length),ceil(warping_window_size*max([x_length,y_length]))]);
                [~,x_path,y_path] = dtw(x_subsignal,y_subsignal,window_size);
                iterator = 1;
                for j=1:lengths(action_idx,mean_subsignals(action_idx,subsignal_idx))
                    temp = 0;
                    num = 0;
                    while iterator<=size(x_path,1) && x_path(iterator,1)==j 
                        temp = temp + y_subsignal(1,y_path(iterator),1,1);
                        num = num + 1;
                        iterator = iterator + 1;
                    end
                    if num~=0
                        actions_warped(action_idx,i,subsignal_idx,j) = temp/num;
                    else
                        actions_warped(action_idx,i,subsignal_idx,j) = actions_warped(action_idx,i,subsignal_idx,j-1);
                    end
                end
            end
        end
    end
    
    temp_mean = zeros(size(actions,1),size(train_signals,2),size(train_signals,3));
    for action_idx=1:size(actions,1)
        for subsignal_idx=1:number_of_subsignals
            for frame_idx=1:lengths(action_idx,mean_subsignals(action_idx,subsignal_idx))
                temp_mean(action_idx,subsignal_idx,frame_idx) = sum(actions_warped(action_idx,1:observations_counter(action_idx,1),subsignal_idx,frame_idx))/observations_counter(action_idx,1);
            end
        end
    end
    
%     draw_template(actions,lengths,mean_subsignals,actions_warped,temp_mean);
    
    template_signals = zeros(size(actions,1),size(train_signals,2),size(train_signals,3));
    template_lengths = zeros(size(actions,1),size(train_signals,2));
    for action_idx=1:size(actions,1)
        for subsignal_idx=1:number_of_subsignals
            template_lengths(action_idx,subsignal_idx) = lengths(action_idx,mean_subsignals(action_idx,subsignal_idx));
            template_signals(action_idx,subsignal_idx,1:template_lengths(action_idx,subsignal_idx)) = permute(temp_mean(action_idx,subsignal_idx,1:lengths(action_idx,mean_subsignals(action_idx,subsignal_idx))),[1 3 2]);
%             template_lengths(action_idx,subsignal_idx) = 2^nextpow2(lengths(action_idx,mean_subsignals(action_idx,subsignal_idx)));
%             template_signals(action_idx,subsignal_idx,1:template_lengths(action_idx,subsignal_idx)) = resample(permute(temp_mean(action_idx,subsignal_idx,1:lengths(action_idx,mean_subsignals(action_idx,subsignal_idx))),[1 3 2]),template_lengths(action_idx,subsignal_idx),lengths(action_idx,mean_subsignals(action_idx,subsignal_idx)));
        end
    end
    
    for action_idx=1:size(actions,1)
        for subsignal_idx=1:number_of_subsignals
%             display((template_lengths(action_idx,subsignal_idx)-lengths(action_idx,mean_subsignals(action_idx,subsignal_idx)))/(template_lengths(action_idx,subsignal_idx)));
        end
    end
    
    % save results for debug (time consuming)
    if debug==1
        save_to_file('template',reshape(template_signals,size(template_signals,1),1,size(template_signals,2),size(template_signals,3)),[1],[1],4:9);
    end
    
end
