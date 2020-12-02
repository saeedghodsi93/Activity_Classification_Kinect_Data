function [ complete_skeleton,number_of_samples,action_length ] = load_MSRAction3D_dataset( dataset_idx,path,reload )
    if reload==0
        % load skeleton with all available data from a mat file
        disp('Loading Dataset...');
        
        cd('dataset')
        load('MSRAction3D.mat','complete_skeleton','number_of_samples','action_length','number_of_folders','number_of_tests','number_of_actions','number_of_joints','number_of_dimensions','scale_factor');
        cd('..')
        
    elseif reload==1
        % save skeleton with all available data in a mat file
        disp('Reloading Dataset...');
        
        % dataset parameters
        number_of_folders=10;
        number_of_tests=3;
        ActionName={'high_arm_wave','horizontal_arm_wave','hammer','hand_catch','forward_punch','high_throw','draw_x','draw_tick','draw_circle','hand_clap','two_hand_wave','side_boxing','bend','forward_kick','side_kick','jogging','tennis_swing','tennis_serve','golf_swing','pickup_and_throw'};
        number_of_actions=size(ActionName,2);
        number_of_samples = zeros(number_of_folders,number_of_actions);
        number_of_joints=20;
        number_of_dimensions=3;
        scale_factor=100;
    
        for i=1:number_of_folders
            for j=1:number_of_actions
                number_of_samples(i,j)=3;
            end 
        end
        number_of_samples(4,1)=0;
        number_of_samples(3,2)=2;
        number_of_samples(4,2)=0;
        number_of_samples(4,3)=0;
        number_of_samples(3,4)=1;
        number_of_samples(4,4)=0;
        number_of_samples(4,5)=0;
        number_of_samples(6,5)=2;
        number_of_samples(4,6)=0;
        number_of_samples(6,6)=2;
        number_of_samples(4,7)=1;
        number_of_samples(7,7)=2;
        number_of_samples(9,13)=0;
        number_of_samples(3,14)=2;
        number_of_samples(2,15)=2;
        number_of_samples(3,15)=0;
        number_of_samples(4,15)=0;
        number_of_samples(5,15)=0;
        number_of_samples(7,20)=1;
        number_of_samples(10,20)=2;

        complete_skeleton = zeros(number_of_folders,[],number_of_actions,[],number_of_joints,number_of_dimensions);
        action_length = zeros(number_of_folders,[],number_of_actions);
        
        for folder_idx = 1:number_of_folders
            for action_idx =1:number_of_actions
                for test_idx = 1:number_of_samples(folder_idx,action_idx)
                    filename = strcat(path,'a',num2str(action_idx),'_s',num2str(folder_idx),'_e',num2str(test_idx),'_skeleton3D.txt'); % address of files
                    fileID = fopen(filename);
                    data = textscan(fileID,'%f%f%f%f%*[^\n]','Delimiter',' ');
                    fclose(fileID);
                    
                    % action length matrix
                    action_length(folder_idx,test_idx,action_idx)=size(data{1,1},1)/number_of_joints;
                    for frame_idx = 1:action_length(folder_idx,test_idx,action_idx)
                        for joint_idx = 1:number_of_joints
                            % skeleton matrix
                            complete_skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_idx,1)=data{1,1}((frame_idx-1)*number_of_joints+joint_idx);
                            complete_skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_idx,2)=data{1,2}((frame_idx-1)*number_of_joints+joint_idx);
                            complete_skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_idx,3)=data{1,3}((frame_idx-1)*number_of_joints+joint_idx);
                        end
                    end
                    
                end
            end
        end
        
        cd('dataset')
        save('MSRAction3D.mat','complete_skeleton','number_of_samples','action_length','number_of_folders','number_of_tests','number_of_actions','number_of_joints','number_of_dimensions','scale_factor');
        cd('..')
    end

    complete_skeleton = complete_skeleton .*scale_factor;
    
    % action selection
    temp_skeleton = zeros(size(complete_skeleton,1),size(complete_skeleton,2),[],size(complete_skeleton,4),size(complete_skeleton,5),size(complete_skeleton,6));
    temp_number_of_samples = zeros(size(complete_skeleton,1),[]);
    temp_action_length = zeros(size(complete_skeleton,1),size(complete_skeleton,2),[]);
    switch(dataset_idx)
        case 1 % AS1
            temp_skeleton(:,:,1:8,:,:,:) = complete_skeleton(:,:,[2 3 5 6 10 13 18 20],:,:,:);
            temp_number_of_samples(:,1:8) = number_of_samples(:,[2 3 5 6 10 13 18 20]);
            temp_action_length(:,:,1:8) = action_length(:,:,[2 3 5 6 10 13 18 20]);
        case 2 % AS2
            temp_skeleton(:,:,1:8,:,:,:) = complete_skeleton(:,:,[1 4 7 8 9 11 12 14],:,:,:);
            temp_number_of_samples(:,1:8) = number_of_samples(:,[1 4 7 8 9 11 12 14]);
            temp_action_length(:,:,1:8) = action_length(:,:,[1 4 7 8 9 11 12 14]);
        case 3 % AS3
            temp_skeleton(:,:,1:8,:,:,:) = complete_skeleton(:,:,[6 14 15 16 17 18 19 20],:,:,:);
            temp_number_of_samples(:,1:8) = number_of_samples(:,[6 14 15 16 17 18 19 20]);
            temp_action_length(:,:,1:8) = action_length(:,:,[6 14 15 16 17 18 19 20]);
        case 4 % overall
            temp_skeleton = complete_skeleton;
            temp_number_of_samples = number_of_samples;
            temp_action_length = action_length;
        otherwise
            error('Wrong Dataset Index!');
    end
    complete_skeleton = temp_skeleton;
    number_of_samples = temp_number_of_samples;
    action_length = temp_action_length;
    
end
