function [ average_accuracy,average_precision,average_recall ] = run( dataset_idx,cross_validation_idx,alignment_idx,smoothing_window_size,warping_window_size )

    debug=0; % save debug files

    [skeleton,number_of_samples,action_length,joint_num,joint_pair,joint_pair_begin,joint_pair_end,base_joint_center,base_joint_left,base_joint_right,scaling_joints]=load_dataset(dataset_idx);

    skeleton=smoothing(skeleton,number_of_samples,action_length,smoothing_window_size);

    skeleton_distance=calculate_distance(skeleton,number_of_samples,joint_pair_begin,joint_pair_end);

    skeleton=alignment(alignment_idx,skeleton,number_of_samples,action_length,joint_num,base_joint_center,base_joint_left,base_joint_right,scaling_joints);

    % draw_skeleton(skeleton,number_of_samples,action_length,2,1,1,joint_pair,20);

    signals=create_signals(skeleton,skeleton_distance,number_of_samples,debug);
    
    [average_accuracy,average_precision,average_recall]=cross_validation(dataset_idx,cross_validation_idx,warping_window_size,signals,number_of_samples,action_length,size(skeleton),debug);

end
