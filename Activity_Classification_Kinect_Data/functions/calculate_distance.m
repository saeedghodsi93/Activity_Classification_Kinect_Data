function [ skeleton_distance ] = calculate_distance( skeleton,number_of_samples,joint_pair_begin,joint_pair_end )
disp('Calculating Pairwise Distances...');

number_of_pairs = size(joint_pair_begin,2);
skeleton_distance=zeros(size(skeleton,1),size(skeleton,2),size(skeleton,3),size(skeleton,4),number_of_pairs,size(skeleton,6));
for folder_idx = 1:size(skeleton,1)
    for action_idx = 1:size(skeleton,3)
        for test_idx = 1:number_of_samples(folder_idx,action_idx)
            for frame_idx = 1:size(skeleton,4)
                for pair_idx = 1:number_of_pairs
                    skeleton_distance(folder_idx,test_idx,action_idx,frame_idx,pair_idx,:) = skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_pair_end(pair_idx),:)-skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_pair_begin(pair_idx),:);
                end
            end
        end
    end
end
end
