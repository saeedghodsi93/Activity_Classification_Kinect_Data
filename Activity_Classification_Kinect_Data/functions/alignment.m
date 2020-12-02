function [ aligned_skeleton ] = alignment( alignment_idx,skeleton,number_of_samples,action_length,joint_num,base_joint_center,base_joint_left,base_joint_right,scaling_joints )
    
    scale_factor=zeros(size(skeleton,1),1);
    for folder_idx = 1:size(skeleton,1)
        height=[];
        counter=0;
        for action_idx = 1:size(skeleton,3)
            for test_idx = 1:number_of_samples(folder_idx,action_idx)
                for frame_idx = 1:action_length(folder_idx,test_idx,action_idx)
                    pos=permute(skeleton(folder_idx,test_idx,action_idx,frame_idx,scaling_joints,:),[6 5 1 2 3 4]);
                    diff=pos(:,1)-(pos(:,2)+pos(:,3))/2;
                    if sin(2*pi/3)<diff(2)/norm(diff)
                        counter=counter+1; 
                        height(counter) = floor(norm(diff));
                    end
                end
            end
        end
        scale_factor(folder_idx,1)=50/max(height);
    end
    
    switch alignment_idx
        case 1 % do nothing
            aligned_skeleton=skeleton;
        
        case 2 % action alignment
            disp('Alignment...');

            base_frame=1;
            aligned_skeleton = zeros(size(skeleton));
            for folder_idx = 1:size(skeleton,1)
                for action_idx = 1:size(skeleton,3)
                    for test_idx = 1:number_of_samples(folder_idx,action_idx)
                        pos=permute(skeleton(folder_idx,test_idx,action_idx,base_frame,base_joint_center,:),[5 6 1 2 3 4]);
                        pos = pos + [-50 0 50];
                        body_x_direction=permute((skeleton(folder_idx,test_idx,action_idx,base_frame,base_joint_right,:)-skeleton(folder_idx,test_idx,action_idx,base_frame,base_joint_left,:)),[6 1 2 3 4 5]);
                        angle=atan2(body_x_direction(3,:,:,:,:,:),body_x_direction(1,:,:,:,:,:));
                        angle = angle - pi/6;
                        rotation_matrix=[cos(angle),0,-sin(angle);0,1,0;sin(angle),0,cos(angle)];
                        for frame_idx=1:action_length(folder_idx,test_idx,action_idx)
                            for joint_idx=1:size(skeleton,5)
                                r=permute(skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_idx,:),[5 6 1 2 3 4])-pos;
                                aligned_skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_idx,:)=r*rotation_matrix;
                            end
                        end
                    end
                end
            end

        case 3 % frame alignment    
            disp('Alignment...');

            base_frame=1;
            aligned_skeleton = zeros(size(skeleton));
            for folder_idx = 1:size(skeleton,1)
                for action_idx = 1:size(skeleton,3)
                    for test_idx = 1:number_of_samples(folder_idx,action_idx)
                        for frame_idx=1:action_length(folder_idx,test_idx,action_idx)
                            pos=permute(skeleton(folder_idx,test_idx,action_idx,frame_idx,base_joint_center,:),[5 6 1 2 3 4]);
                            body_x_direction=permute((skeleton(folder_idx,test_idx,action_idx,base_frame,base_joint_right,:)-skeleton(folder_idx,test_idx,action_idx,base_frame,base_joint_left,:)),[6 1 2 3 4 5]);
                            angle=atan2(body_x_direction(3,:,:,:,:,:),body_x_direction(1,:,:,:,:,:));
%                             angle = angle - pi/6;
                            rotation_matrix=[cos(angle),0,-sin(angle);0,1,0;sin(angle),0,cos(angle)];
                            for joint_idx=1:size(skeleton,5)
                                r=permute(skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_idx,:),[5 6 1 2 3 4])-pos;
%                                 r=floor(r*scale_factor(folder_idx,1));
                                aligned_skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_idx,:)=r*rotation_matrix;
                            end
                        end
                    end
                end
            end
            
        case 4 % fusion
            disp('Alignment...');

            base_frame=1;
            aligned_skeleton = zeros(size(skeleton,1),size(skeleton,2),size(skeleton,3),size(skeleton,4),2*size(skeleton,5),size(skeleton,6));
            for folder_idx = 1:size(skeleton,1)
                for action_idx = 1:size(skeleton,3)
                    for test_idx = 1:number_of_samples(folder_idx,action_idx)
                        
                        pos=permute(skeleton(folder_idx,test_idx,action_idx,base_frame,base_joint_center,:),[5 6 1 2 3 4]);
                        body_x_direction=permute((skeleton(folder_idx,test_idx,action_idx,base_frame,base_joint_right,:)-skeleton(folder_idx,test_idx,action_idx,base_frame,base_joint_left,:)),[6 1 2 3 4 5]);
                        angle=atan2(body_x_direction(3,:,:,:,:,:),body_x_direction(1,:,:,:,:,:));
                        rotation_matrix=[cos(angle),0,-sin(angle);0,1,0;sin(angle),0,cos(angle)];
                        for frame_idx=1:action_length(folder_idx,test_idx,action_idx)
                            for joint_idx=1:size(skeleton,5)
                                r=permute(skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_idx,:),[5 6 1 2 3 4])-pos;
                                aligned_skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_idx,:)=r*rotation_matrix;
                            end
                        end
                        
                        for frame_idx=1:action_length(folder_idx,test_idx,action_idx)
                            pos=permute(skeleton(folder_idx,test_idx,action_idx,frame_idx,base_joint_center,:),[5 6 1 2 3 4]);
                            body_x_direction=permute((skeleton(folder_idx,test_idx,action_idx,frame_idx,base_joint_right,:)-skeleton(folder_idx,test_idx,action_idx,frame_idx,base_joint_left,:)),[6 1 2 3 4 5]);
                            angle=atan2(body_x_direction(3,:,:,:,:,:),body_x_direction(1,:,:,:,:,:));
                            rotation_matrix=[cos(angle),0,-sin(angle);0,1,0;sin(angle),0,cos(angle)];
                            for joint_idx=1:size(skeleton,5)
                                r=permute(skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_idx,:),[5 6 1 2 3 4])-pos;
%                                 r=floor(r*scale_factor(folder_idx,1));
                                aligned_skeleton(folder_idx,test_idx,action_idx,frame_idx,size(skeleton,5)+joint_idx,:)=r*rotation_matrix;
                            end
                        end
                        
                    end
                end
            end
            
    end
    
    % joint selection
    aligned_skeleton=aligned_skeleton(:,:,:,:,joint_num,:);
    
end
