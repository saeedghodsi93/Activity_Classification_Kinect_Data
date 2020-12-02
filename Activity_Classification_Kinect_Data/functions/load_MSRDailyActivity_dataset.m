function [ complete_skeleton,number_of_samples,action_length ] = load_MSRDailyActivity_dataset( path,reload )
    if reload==0
        % load skeleton with all available data from a mat file
        disp('Loading Dataset...');
        
        cd('dataset')
        load('MSRDailyActivity.mat','complete_skeleton','action_length','number_of_folders','number_of_tests','number_of_actions','number_of_joints','number_of_dimensions','scale_factor');
        cd('..')
        
    elseif reload==1
        % save skeleton with all available data in a mat file
        disp('Reloading Dataset...');
        
        % dataset parameters
        number_of_folders=10;
        number_of_tests=2;
        ActionName={'drink','eat','readbook','callcellphone','writeonpaper','uselaptop','usevacuumcleaner','cheerup','sitstill','tosspaper','playgame','liedownonsofa','walk','playguitar','standup','sitdown'};
        number_of_actions=size(ActionName,2);
        number_of_joints=20;
        number_of_dimensions=3;
        scale_factor=100;
        
        complete_skeleton = zeros(number_of_folders,number_of_tests,number_of_actions,[],number_of_joints,number_of_dimensions);
        action_length = zeros(number_of_folders,number_of_tests,number_of_actions);
        for folder_idx = 1:number_of_folders
            for test_idx = 1:number_of_tests
                for actionName = ActionName
                    if strcmp(actionName,'drink')
                        action_idx=1;
                    elseif strcmp(actionName,'eat')
                        action_idx=2;
                    elseif strcmp(actionName,'readbook')
                        action_idx=3;
                    elseif strcmp(actionName,'callcellphone')
                        action_idx=4;
                    elseif strcmp(actionName,'writeonpaper')
                        action_idx=5;
                    elseif strcmp(actionName,'uselaptop')
                        action_idx=6;
                    elseif strcmp(actionName,'usevacuumcleaner')
                        action_idx=7;
                    elseif strcmp(actionName,'cheerup')
                        action_idx=8;
                    elseif strcmp(actionName,'sitstill')
                        action_idx=9;
                    elseif strcmp(actionName,'tosspaper')
                        action_idx=10;
                    elseif strcmp(actionName,'playgame')
                        action_idx=11;
                    elseif strcmp(actionName,'liedownonsofa')
                        action_idx=12;
                    elseif strcmp(actionName,'walk')
                        action_idx=13;
                    elseif strcmp(actionName,'playguitar')
                        action_idx=14;
                    elseif strcmp(actionName,'standup')
                        action_idx=15;
                    elseif strcmp(actionName,'sitdown')
                        action_idx=16;
                    end
                    
                    % read skeleton file
                    filename=strcat(path,num2str(folder_idx),'\',num2str(test_idx),'\a',num2str(action_idx),'_s',num2str(folder_idx),'_e',num2str(test_idx),'_skeleton.txt');
                    data=dlmread(filename);
                    data_offset=1;
                    frame_offset=1;
                    lines_per_joint=2;
                    lines_per_frame=lines_per_joint*number_of_joints+1;
                    NumFrameSkelSpace=data(1,1);
                    jointMat=zeros(NumFrameSkelSpace,number_of_joints,number_of_dimensions);
                    for i=1:NumFrameSkelSpace
                        for j=1:number_of_joints
                            jointMat(i,j,:)=data(data_offset+lines_per_frame*(i-1)+frame_offset+lines_per_joint*(j-1)+1,1:number_of_dimensions);
                        end
                    end
                    
                    % skeleton matrix
                    complete_skeleton(folder_idx,test_idx,action_idx,1:NumFrameSkelSpace,:,:)=jointMat(:,:,:);

                    % action length matrix
                    action_length(folder_idx,test_idx,action_idx)=NumFrameSkelSpace;
                    
                end
            end
        end
                        
        cd('dataset')
        save('MSRDailyActivity.mat','complete_skeleton','action_length','number_of_folders','number_of_tests','number_of_actions','number_of_joints','number_of_dimensions','scale_factor');
        cd('..')
    end
    
    number_of_samples = zeros(size(complete_skeleton,1),size(complete_skeleton,3));
    for folder_idx = 1:size(complete_skeleton,1)
        for action_idx = 1:size(complete_skeleton,3)
            number_of_samples(folder_idx,action_idx) = size(complete_skeleton,2);
        end
    end
    
    complete_skeleton = complete_skeleton .*scale_factor;
    
end
