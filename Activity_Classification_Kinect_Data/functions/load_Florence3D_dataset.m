function [ complete_skeleton,number_of_samples,action_length ] = load_Florence3D_dataset( path,reload )
    if reload==0
        % load skeleton with all available data from a mat file
        disp('Loading Dataset...');
        
        cd('dataset')
        load('Florence3D.mat','complete_skeleton','number_of_samples','action_length','number_of_folders','number_of_tests','number_of_actions','number_of_joints','number_of_dimensions','scale_factor');
        cd('..')
        
    elseif reload==1
        % save skeleton with all available data in a mat file
        disp('Reloading Dataset...');
        
        % dataset parameters
        number_of_folders=10;
        number_of_tests=5;
        ActionName={'wave','drink','answer_phone','clap','tight_lace','sit_down','stand_up','read_watch','bow'};
        number_of_actions=size(ActionName,2);
        number_of_samples = zeros(number_of_folders,number_of_actions);
        number_of_joints=15;
        number_of_dimensions=3;
        scale_factor=0.1;
    
        complete_skeleton = zeros(number_of_folders,[],number_of_actions,[],number_of_joints,number_of_dimensions);
        action_length = zeros(number_of_folders,[],number_of_actions);
        
        filename = strcat(path,'skeleton.txt'); % address of files
        %filename = sprintf('%s', filename{1});
        fileID = fopen(filename);
        data = textscan(fileID,'%d%d%d%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%*[^\n]','Delimiter',' ');
        fclose(fileID);
                      
        line_counter = 0;
        current_sample_idx = 1;
        while(1)
            if(line_counter==4017) 
                break;
            end

            frame_counter = 0;
            sample = zeros([],number_of_joints,number_of_dimensions);
            while(1)
                line_counter = line_counter + 1;
                if(line_counter==4017) 
                    break;
                end

                frame_counter = frame_counter + 1;
                sample_idx = data{1,1}(line_counter);
                if(sample_idx~=current_sample_idx)
                    line_counter = line_counter - 1;
                    frame_counter = frame_counter - 1;
                    current_sample_idx = sample_idx;
                    break;
                end

                folder_idx = data{1,2}(line_counter);
                action_idx = data{1,3}(line_counter);

                sample(frame_counter,1,1) = data{1,4}(line_counter);
                sample(frame_counter,1,2) = data{1,5}(line_counter);
                sample(frame_counter,1,3) = data{1,6}(line_counter);
                sample(frame_counter,2,1) = data{1,7}(line_counter);
                sample(frame_counter,2,2) = data{1,8}(line_counter);
                sample(frame_counter,2,3) = data{1,9}(line_counter);
                sample(frame_counter,3,1) = data{1,10}(line_counter);
                sample(frame_counter,3,2) = data{1,11}(line_counter);
                sample(frame_counter,3,3) = data{1,12}(line_counter);
                sample(frame_counter,4,1) = data{1,13}(line_counter);
                sample(frame_counter,4,2) = data{1,14}(line_counter);
                sample(frame_counter,4,3) = data{1,15}(line_counter);
                sample(frame_counter,5,1) = data{1,16}(line_counter);
                sample(frame_counter,5,2) = data{1,17}(line_counter);
                sample(frame_counter,5,3) = data{1,18}(line_counter);
                sample(frame_counter,6,1) = data{1,19}(line_counter);
                sample(frame_counter,6,2) = data{1,20}(line_counter);
                sample(frame_counter,6,3) = data{1,21}(line_counter);
                sample(frame_counter,7,1) = data{1,22}(line_counter);
                sample(frame_counter,7,2) = data{1,23}(line_counter);
                sample(frame_counter,7,3) = data{1,24}(line_counter);
                sample(frame_counter,8,1) = data{1,25}(line_counter);
                sample(frame_counter,8,2) = data{1,26}(line_counter);
                sample(frame_counter,8,3) = data{1,27}(line_counter);
                sample(frame_counter,9,1) = data{1,28}(line_counter);
                sample(frame_counter,9,2) = data{1,29}(line_counter);
                sample(frame_counter,9,3) = data{1,30}(line_counter);
                sample(frame_counter,10,1) = data{1,31}(line_counter);
                sample(frame_counter,10,2) = data{1,32}(line_counter);
                sample(frame_counter,10,3) = data{1,33}(line_counter);
                sample(frame_counter,11,1) = data{1,34}(line_counter);
                sample(frame_counter,11,2) = data{1,35}(line_counter);
                sample(frame_counter,11,3) = data{1,36}(line_counter);
                sample(frame_counter,12,1) = data{1,37}(line_counter);
                sample(frame_counter,12,2) = data{1,38}(line_counter);
                sample(frame_counter,12,3) = data{1,39}(line_counter);
                sample(frame_counter,13,1) = data{1,40}(line_counter);
                sample(frame_counter,13,2) = data{1,41}(line_counter);
                sample(frame_counter,13,3) = data{1,42}(line_counter);
                sample(frame_counter,14,1) = data{1,43}(line_counter);
                sample(frame_counter,14,2) = data{1,44}(line_counter);
                sample(frame_counter,14,3) = data{1,45}(line_counter);
                sample(frame_counter,15,1) = data{1,46}(line_counter);
                sample(frame_counter,15,2) = data{1,47}(line_counter);
                sample(frame_counter,15,3) = data{1,48}(line_counter);

            end

            number_of_samples(folder_idx,action_idx) = number_of_samples(folder_idx,action_idx) + 1;

            % skeleton matrix
            complete_skeleton(folder_idx,number_of_samples(folder_idx,action_idx),action_idx,1:frame_counter,:,:)=sample;

            % action length matrix
            action_length(folder_idx,number_of_samples(folder_idx,action_idx),action_idx)=frame_counter;

        end
                        
        cd('dataset')
        save('Florence3D.mat','complete_skeleton','number_of_samples','action_length','number_of_folders','number_of_tests','number_of_actions','number_of_joints','number_of_dimensions','scale_factor');
        cd('..')
    end

    complete_skeleton = complete_skeleton .*scale_factor;
    
end
