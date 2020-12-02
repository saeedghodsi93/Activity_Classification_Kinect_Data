function [ complete_skeleton,number_of_samples,action_length ] = load_CAD_dataset( dataset_idx,path,reload )
    if reload==0
        % load skeleton with all available data from a mat file
        disp('Loading Dataset...');
        
        cd('dataset')
        load('CAD_60.mat','complete_skeleton','action_length','number_of_folders','number_of_tests','number_of_actions','number_of_joints','number_of_dimensions','scale_factor');
        cd('..')
        
    elseif reload==1
        % save skeleton with all available data in a mat file
        disp('Reloading Dataset...');
        
        % dataset parameters
        number_of_folders=4;
        number_of_tests = 1;
        ActionName={'still','talking_on_the_phone','writing_on_whiteboard','drinking_water','rinsing_mouth','brushing_teeth','wearing_contact_lenses','talking_on_couch','relaxing_on_couch','cooking_chopping','cooking_stirring','opening_pill_container','working_on_computer','random'};
        number_of_actions=size(ActionName,2);
        number_of_joints=15;
        number_of_dimensions=3;
        scale_factor = 0.1;
        
        complete_skeleton = zeros(number_of_folders,2*number_of_tests,number_of_actions,[],number_of_joints,number_of_dimensions);
        action_length = zeros(number_of_folders,2*number_of_tests,number_of_actions);
        for folder_idx = 1:number_of_folders
            for test_idx = 1:number_of_tests
                for actionName = ActionName
                    if strcmp(actionName,'still')
                        action_idx=1;
                    elseif strcmp(actionName,'talking_on_the_phone')
                        action_idx=2;
                    elseif strcmp(actionName,'writing_on_whiteboard')
                        action_idx=3;
                    elseif strcmp(actionName,'drinking_water')
                        action_idx=4;
                    elseif strcmp(actionName,'rinsing_mouth')
                        action_idx=5;
                    elseif strcmp(actionName,'brushing_teeth')
                        action_idx=6;
                    elseif strcmp(actionName,'wearing_contact_lenses')
                        action_idx=7;
                    elseif strcmp(actionName,'talking_on_couch')
                        action_idx=8;
                    elseif strcmp(actionName,'relaxing_on_couch')
                        action_idx=9;
                    elseif strcmp(actionName,'cooking_chopping')
                        action_idx=10;
                    elseif strcmp(actionName,'cooking_stirring')
                        action_idx=11;
                    elseif strcmp(actionName,'opening_pill_container')
                        action_idx=12;
                    elseif strcmp(actionName,'working_on_computer')
                        action_idx=13;
                    elseif strcmp(actionName,'random')
                        action_idx=14;
                    end

                    Address=strcat(path,num2str(folder_idx),'\',num2str(test_idx),'\',ActionName{1,action_idx},'.txt'); % address of files
                   
                    fid = fopen(Address);
                    tline = num2str(fgetl(fid));

                    jMat = zeros([],number_of_joints,number_of_dimensions);
                    while (strcmp(tline,'END') == 0),
                        [fnum,tline] = strtok(tline,',');
                        fnum=str2num(fnum);

                        joints1to11 = zeros(11,14);
                        joints12to15 = zeros(4,4);
                        for i=1:11,
                            for j=1:14,
                                [element,tline] = strtok(tline,',');
                                joints1to11(i,j) = str2num(element);
                            end
                        end
                        for i=1:4,
                            for j=1:4,
                                [element,tline] = strtok(tline,',');
                                joints12to15(i,j) = str2num(element);
                            end
                        end

                        % joints position matrix
                        for i=1:11,
                            jMat(fnum,i,:) = joints1to11(i,[11,12,13]);
                        end
                        for i=1:4,
                            jMat(fnum,i+11,:) = joints12to15(i,[1,2,3]);
                        end

                        [element,tline] = strtok(tline,',');
                        if strcmp(element, '') ~=1,
                            error('ERROR! more data exist... parsing error..');
                        end

                        % read next line
                        tline = fgetl(fid);  

                    end

                    % number of frames
                    NumFrameSkelSpace=fnum;

                    % skeleton matrix
                    complete_skeleton(folder_idx,test_idx,action_idx,1:NumFrameSkelSpace,:,:)=jMat;

                    % action length matrix
                    action_length(folder_idx,test_idx,action_idx)=NumFrameSkelSpace;

                end
            end
        end
        
        % mirror actions
        for folder_idx = 1:number_of_folders
            for test_idx = 1:number_of_tests
                for action_idx = 1:number_of_actions
                    for frame_idx = 1:action_length(folder_idx,test_idx,action_idx)
                        plan_norm = complete_skeleton(folder_idx,test_idx,action_idx,frame_idx,4,:)-complete_skeleton(folder_idx,test_idx,action_idx,frame_idx,6,:);
                        plan_norm = permute(plan_norm,[6 1 2 3 4 5]);
                        plan_norm(2) = 0;
                        plan_norm = plan_norm ./ norm(plan_norm);
                        for joint_idx = 1:number_of_joints
                            diff = complete_skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_idx,:) - complete_skeleton(folder_idx,test_idx,action_idx,frame_idx,3,:);
                            diff = permute(diff,[6 1 2 3 4 5]);
                            project = 2*dot(diff,plan_norm);
                            mirror = permute(complete_skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_idx,:),[6 1 2 3 4 5]) - project .* plan_norm;

                            switch(joint_idx)
                                case 1 % head
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,1,:) = mirror;
                                case 2 % neck
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,2,:) = mirror;
                                case 3 % torso
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,3,:) = mirror;
                                case 4 % left shoulder
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,6,:) = mirror;
                                case 5 % left elbow
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,7,:) = mirror;
                                case 6 % right shoulder
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,4,:) = mirror;
                                case 7 % right elbow
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,5,:) = mirror;
                                case 8 % left hip
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,10,:) = mirror;
                                case 9 % left knee
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,11,:) = mirror;
                                case 10 % right hip
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,8,:) = mirror;
                                case 11 % right knee
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,9,:) = mirror;
                                case 12 % left hand
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,13,:) = mirror;
                                case 13 % right hand
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,12,:) = mirror;
                                case 14 % left foot
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,15,:) = mirror;
                                case 15 % right foot
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,14,:) = mirror;
                                otherwise
                                    error('Invalid Joint Number!');
                            end
                            
                        end
                    end
                    
                    % action length matrix
                    action_length(folder_idx,test_idx+number_of_tests,action_idx)=action_length(folder_idx,test_idx,action_idx);

                end
            end
        end

        cd('dataset')
        save('CAD_60.mat','complete_skeleton','action_length','number_of_folders','number_of_tests','number_of_actions','number_of_joints','number_of_dimensions','scale_factor');
        cd('..')
    end
    
    number_of_samples = zeros(size(complete_skeleton,1),size(complete_skeleton,3));
    for folder_idx = 1:size(complete_skeleton,1)
        for action_idx = 1:size(complete_skeleton,3)
            number_of_samples(folder_idx,action_idx) = size(complete_skeleton,2);
        end
    end
    
    complete_skeleton = complete_skeleton .*scale_factor;
    
    % turn off mirror
%     complete_skeleton = complete_skeleton(:,1,:,:,:,:);
%     action_length = action_length(:,1,:);
    
    % action selection
    temp_skeleton = zeros(size(complete_skeleton,1),size(complete_skeleton,2),[],size(complete_skeleton,4),size(complete_skeleton,5),size(complete_skeleton,6));
    temp_action_length = zeros(size(complete_skeleton,1),size(complete_skeleton,2),[]);
    switch(dataset_idx)
        case 1 % Bathroom
            temp_skeleton(:,:,1:3,:,:,:) = complete_skeleton(:,:,[5 6 7],:,:,:);
            temp_action_length(:,:,1:3) = action_length(:,:,[5 6 7]);
        case 2 % Bedroom
            temp_skeleton(:,:,1:3,:,:,:) = complete_skeleton(:,:,[2 4 12],:,:,:);
            temp_action_length(:,:,1:3) = action_length(:,:,[2 4 12]);
        case 3 % Kitchen
            temp_skeleton(:,:,1:4,:,:,:) = complete_skeleton(:,:,[4 10 11 12],:,:,:);
            temp_action_length(:,:,1:4) = action_length(:,:,[4 10 11 12]);
        case 4 % Living Room
            temp_skeleton(:,:,1:4,:,:,:) = complete_skeleton(:,:,[2 4 8 9],:,:,:);
            temp_action_length(:,:,1:4) = action_length(:,:,[2 4 8 9]);
        case 5 % Office
            temp_skeleton(:,:,1:4,:,:,:) = complete_skeleton(:,:,[2 3 4 13],:,:,:);
            temp_action_length(:,:,1:4) = action_length(:,:,[2 3 4 13]);
        case 6 % overall
            temp_skeleton = complete_skeleton;
            temp_action_length = action_length;
        otherwise
            error('Wrong Dataset Index!');
    end
    complete_skeleton = temp_skeleton;
    action_length = temp_action_length;
    
end
