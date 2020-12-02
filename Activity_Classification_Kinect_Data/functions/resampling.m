function [ skeleton ] = resampling( skeleton,action_length )
    disp('Resampling...');

%     temp_skeleton = zeros(size(skeleton,1),size(skeleton,2),size(skeleton,3),sequence_length,size(skeleton,5),size(skeleton,6));    
%     for folder_idx = 1:size(skeleton,1)
%         for test_idx = 1:size(skeleton,2)
%             for action_idx = 1:size(skeleton,3)
%                 for joint_idx = 1:size(skeleton,5)
%                     for dimension_idx = 1:size(skeleton,6)
%                         temp_skeleton(folder_idx,test_idx,action_idx,:,joint_idx,dimension_idx) = resample(permute(skeleton(folder_idx,test_idx,action_idx,1:action_length(folder_idx,test_idx,action_idx),joint_idx,dimension_idx),[4 5 6 1 2 3]),sequence_length,action_length(folder_idx,test_idx,action_idx));
%                     end
%                 end
%             end
%         end
%     end
%     skeleton = temp_skeleton;
    
end
