function [ complete_skeleton,number_of_samples,action_length ] = load_CAD_120_dataset(path,reload )
    
    if reload==0
        % load skeleton with all available data from a mat file
        disp('Loading Dataset...');

        cd('dataset')
        load('CAD_120.mat','complete_skeleton','action_length','number_of_folders','number_of_tests','number_of_actions','number_of_joints','number_of_dimensions','scale_factor');
        cd('..')

    elseif reload==1
        % save skeleton with all available data in a mat file
        disp('Reloading Dataset...');

        % dataset parameters
        number_of_folders=4;
        number_of_tests = 3;
        ActionName={'arranging_objects','cleaning_objects','having_meal','making_cereal','microwaving_food','picking_objects','stacking_objects','taking_food','taking_medicine','unstacking_objects'};
        number_of_actions=size(ActionName,2);
        number_of_joints=15;
        number_of_dimensions=3;
        scale_factor = 0.1;

        complete_skeleton = zeros(number_of_folders,2*number_of_tests,number_of_actions,[],number_of_joints,number_of_dimensions);
        action_length = zeros(number_of_folders,number_of_tests,number_of_actions);
        for folder_idx = 1:number_of_folders
            for test_idx = 1:number_of_tests
                for actionName = ActionName
                    if strcmp(actionName,'arranging_objects')
                        action_idx=1;
                    elseif strcmp(actionName,'cleaning_objects')
                        action_idx=2;
                    elseif strcmp(actionName,'having_meal')
                        action_idx=3;
                    elseif strcmp(actionName,'making_cereal')
                        action_idx=4;
                    elseif strcmp(actionName,'microwaving_food')
                        action_idx=5;
                    elseif strcmp(actionName,'picking_objects')
                        action_idx=6;
                    elseif strcmp(actionName,'stacking_objects')
                        action_idx=7;
                    elseif strcmp(actionName,'taking_food')
                        action_idx=8;
                    elseif strcmp(actionName,'taking_medicine')
                        action_idx=9;
                    elseif strcmp(actionName,'unstacking_objects')
                        action_idx=10;
                    end

                    address=strcat(path,num2str(folder_idx),'\',num2str(test_idx),'\',ActionName{1,action_idx},'.txt'); % address of files
                    
                    fid = fopen(address);
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
        
        % load the objects data
        numberOfObjects = load_number_of_objects();
        object_data_3d = read_object_data_in_3d();
        complete_skeleton = attach_skeleton_object(complete_skeleton,object_data_3d,numberOfObjects,action_length);
    
        % mirror actions
        for folder_idx = 1:size(complete_skeleton,1)
            for test_idx = 1:(size(complete_skeleton,2)/2)
                for action_idx = 1:size(complete_skeleton,3)
                    for frame_idx = 1:action_length(folder_idx,test_idx,action_idx)
                        plan_norm = complete_skeleton(folder_idx,test_idx,action_idx,frame_idx,4,:)-complete_skeleton(folder_idx,test_idx,action_idx,frame_idx,6,:);
                        plan_norm = permute(plan_norm,[6 1 2 3 4 5]);
                        plan_norm(2) = 0;
                        plan_norm = plan_norm ./ norm(plan_norm);
                        for joint_idx = 1:size(complete_skeleton,5)
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
                                otherwise % objects
                                    complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,joint_idx,:) = complete_skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_idx,:);
%                                     if joint_idx <= 15 + numberOfObjects{folder_index,test_index,action_index}
%                                         complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,31+numberOfObjects{folder_index,test_index,action_index}-joint_idx,:) = mirror;
%                                     else
%                                         complete_skeleton(folder_idx,test_idx+number_of_tests,action_idx,frame_idx,joint_idx,:) = mirror;
%                                     end
                            end
                            
                        end
                    end
                    
                    % action length matrix
                    action_length(folder_idx,test_idx+number_of_tests,action_idx)=action_length(folder_idx,test_idx,action_idx);

                end
            end
        end

        cd('dataset')
        save('CAD_120.mat','complete_skeleton','action_length','number_of_folders','number_of_tests','number_of_actions','number_of_joints','number_of_dimensions','scale_factor');
        cd('..')
    end
    
    complete_skeleton = complete_skeleton .* scale_factor;
    
    % turn off mirror
    half_size = size(complete_skeleton,2)/2;
    complete_skeleton = complete_skeleton(:,1:half_size,:,:,:,:);
    action_length = action_length(:,1:half_size,:);
    
    number_of_samples = zeros(size(complete_skeleton,1),size(complete_skeleton,3));
    for folder_idx = 1:size(complete_skeleton,1)
        for action_idx = 1:size(complete_skeleton,3)
            number_of_samples(folder_idx,action_idx) = size(complete_skeleton,2);
        end
    end
    
end
