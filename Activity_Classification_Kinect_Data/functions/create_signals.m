function [ signals ] = create_signals( skeleton,skeleton_distance,number_of_samples,debug )
    disp('Creating Signals...');    
    
    number_of_joints=size(skeleton,5);
    number_of_pairs=size(skeleton_distance,5);
    number_of_dimensions=size(skeleton,6);
    signals=zeros(size(skeleton,1),size(skeleton,2),size(skeleton,3),[],size(skeleton,4));
    for folder_idx = 1:size(skeleton,1)
        for action_idx = 1:size(skeleton,3)
            for test_idx = 1:number_of_samples(folder_idx,action_idx)
                for frame_idx = 1:size(skeleton,4)
                    pos=permute(skeleton(folder_idx,test_idx,action_idx,frame_idx,:,:),[5 6 1 2 3 4]);
                    for joint_idx=1:number_of_joints
                        for dim_idx=1:number_of_dimensions
                            signals(folder_idx,test_idx,action_idx,(joint_idx-1)*number_of_dimensions+dim_idx,frame_idx)=pos(joint_idx,dim_idx);
                        end
                    end
                    dis=permute(skeleton_distance(folder_idx,test_idx,action_idx,frame_idx,:,:),[5 6 1 2 3 4]);
                    for pair_idx=1:number_of_pairs
                        for dim_idx=1:number_of_dimensions
                            signals(folder_idx,test_idx,action_idx,number_of_joints*number_of_dimensions+(pair_idx-1)*number_of_dimensions+dim_idx,frame_idx)=dis(pair_idx,dim_idx);
                        end
                    end
                end
            end
        end
    end
    
    % save results for debug (time consuming)
    if debug==1
        temp_signals=zeros(size(signals,3),[],size(signals,4),size(signals,5));
        for action_idx = 1:size(signals,3)
            number=0;
            for folder_idx = 1:size(signals,1)
                for test_idx = 1:number_of_samples(folder_idx,action_idx)
                    number=number+1;
                    temp_signals(action_idx,number,:,:)=signals(folder_idx,test_idx,action_idx,:,:);
                end
            end
        end
        save_to_file('signal',temp_signals,[1],1:6,28:42); 
    end
    
end
