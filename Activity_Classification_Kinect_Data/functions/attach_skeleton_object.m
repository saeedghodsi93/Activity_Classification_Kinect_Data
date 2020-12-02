function skeleton_object = attach_skeleton_object(complete_skeleton, object_data_3d, numberOfObjects, action_length)
    
    matnumberOfObjects = cell2mat(numberOfObjects);
    MaxNumObjects = max(max(max(matnumberOfObjects(:,:,:))));
    skeleton_object = zeros(size(complete_skeleton,1),size(complete_skeleton,2),size(complete_skeleton,3),size(complete_skeleton,4),size(complete_skeleton,5)+MaxNumObjects,size(complete_skeleton,6));

    fprintf('Attaching Skeleton And Object\n');
    for folder_index = 1:size(complete_skeleton,1)
        for test_index = 1:(size(complete_skeleton,2)/2)
            for action_index = 1:size(complete_skeleton,3)
                for frame_index = 1:action_length(folder_index,test_index,action_index)
                    for joint_index = 1:size(complete_skeleton,5)
                        for dimension_index = 1:size(complete_skeleton,6)
                            skeleton_object(folder_index,test_index,action_index,frame_index,joint_index,dimension_index)=complete_skeleton(folder_index,test_index,action_index,frame_index,joint_index,dimension_index);
                        end
                    end
                end
            end
        end
    end

    for folder_index = 1:size(complete_skeleton,1)
        for test_index = 1:(size(complete_skeleton,2)/2)
            for action_index = 1:size(complete_skeleton,3)
                for object_index = 1 : numberOfObjects{folder_index,test_index,action_index}
                    for frame_index = 1 : action_length(folder_index,test_index ,action_index)
                        for dimension_index = 1:size(complete_skeleton,6)
                            skeleton_object(folder_index,test_index,action_index,frame_index,size(complete_skeleton,5)+object_index,dimension_index) = object_data_3d(folder_index,test_index,action_index,frame_index,object_index,dimension_index);
                        end
                    end
                end
                if numberOfObjects{folder_index,test_index,action_index}<MaxNumObjects
                    for object_index = numberOfObjects{folder_index,test_index,action_index}+1:MaxNumObjects
                        for frame_index = 1:action_length(folder_index,test_index ,action_index)
                            for dimension_index = 1:size(complete_skeleton,6)
%                                 skeleton_object(folder_index,test_index,action_index,frame_index,size(complete_skeleton,5)+object_index,dimension_index) = 0;
                                skeleton_object(folder_index,test_index,action_index,frame_index,size(complete_skeleton,5)+object_index,dimension_index) = skeleton_object(folder_index,test_index,action_index,frame_index,3,dimension_index);
                            end
                        end
                    end
                end
            end
        end
    end
    
end
