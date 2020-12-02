function [ skeleton ] = smoothing( skeleton,number_of_samples,action_length,smoothing_window_size )
    disp('Smoothing...');

    % rounding
    grid_size=1;
    skeleton=skeleton./grid_size;
    skeleton=round(skeleton);
    skeleton=skeleton.*grid_size;
    
    % signal smoothing
    for folder_idx = 1:size(skeleton,1)
        for action_idx = 1:size(skeleton,3)
            for test_idx = 1:number_of_samples(folder_idx,action_idx)
                for joint_idx = 1:size(skeleton,5)
                    for dimension_idx = 1:size(skeleton,6)
                        skeleton(folder_idx,test_idx,action_idx,1:action_length(folder_idx,test_idx,action_idx),joint_idx,dimension_idx) = smooth(skeleton(folder_idx,test_idx,action_idx,1:action_length(folder_idx,test_idx,action_idx),joint_idx,dimension_idx),smoothing_window_size,'moving');
                        %noisy = permute((skeleton(folder_idx,test_idx,action_idx,1:action_length(folder_idx,test_idx,action_idx),joint_idx,dimension_idx)),[4 1 2 3 6 5]);
                        %skeleton(folder_idx,test_idx,action_idx,1:action_length(folder_idx,test_idx,action_idx),joint_idx,dimension_idx) = wden(noisy,'heursure','s','one',5,'sym8');
                    end
                end
            end
        end
    end

end

