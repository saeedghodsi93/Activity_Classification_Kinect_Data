function [ skeleton,number_of_samples,action_length,joint_num,joint_pair,joint_pair_begin,joint_pair_end,base_joint_center,base_joint_left,base_joint_right,scaling_joints ] = load_dataset( dataset_idx )

    % load or reload dataset, 0:load dataset, 1:reload dataset(time consuming)
    reload_idx=0;

    % load skeleton matrix from database
    switch dataset_idx

        case {1,2,3,4,5,6}
            path='C:\MATLAB\Dataset\CAD\Data';
            base_joint_center=3;
            base_joint_left=4;
            base_joint_right=6;
            joint_pair=[ 1  2  2  2  4  5  6  7  3  3  8 10  9 11;
                2  3  4  6  5 12  7 13  8 10  9 11 14 15];
            % joint_num=[1,2,5,7,12,13,14,15];
            joint_num=1:15;
            joint_pair_begin=[5,12];
            joint_pair_end=[7,13];
            scaling_joints=[2,8,10];
            [skeleton,number_of_samples,action_length]=load_CAD_dataset(dataset_idx,path,reload_idx);

        case 7
            path='C:\MATLAB\Dataset\UTKinect\Data';
            base_joint_center=1;
            base_joint_left=5;
            base_joint_right=9;
            joint_pair=[ 1  2  3  3  3  5  6  7  9 10 11  1  1 13 14 15 17 18 19;
                2  3  4  5  9  6  7  8 10 11 12 13 17 14 15 16 18 19 20];
            % joint_num=[4,8,12,14,16,18,20];
            joint_num=1:20;
            joint_pair_begin=[];
            joint_pair_end=[];
            scaling_joints=[3,13,17];
            [skeleton,number_of_samples,action_length]=load_UTKinect_dataset(path,reload_idx);

        case 8
            path='C:\MATLAB\Dataset\UCFKinect\Data';
            base_joint_center=3;
            base_joint_left=4;
            base_joint_right=7;
            joint_pair=[ 1  2  4  5  2  7  8  2  3  10 11 3  13 14;
                2  4  5  6  7  8  9  3  10 11 12 13 14 15];
            % joint_num=[1,5,7,9,11,12,13,14,15];
            joint_num=1:15;
            joint_pair_begin=[5,6,4,7];
            joint_pair_end=[8,9,11,14];
            scaling_joints=[2,10,13];
            [skeleton,number_of_samples,action_length]=load_UCFKinect_dataset(path,reload_idx);

        case 9
            path='C:\MATLAB\Dataset\Florence3D\';
            base_joint_center=3;
            base_joint_left=4;
            base_joint_right=7;
            joint_pair=[ 1  2  2  2  4  5  7  8  3  3 10 11 13 14;
                2  3  4  7  5  6  8  9 10 13 11 12 14 15];
            % joint_num=[4,8,12,14,16,18,20];
            joint_num=1:15;
            joint_pair_begin=[5,6,4,7];
            joint_pair_end=[8,9,11,14];
            scaling_joints=[2,10,13];
            [skeleton,number_of_samples,action_length]=load_Florence3D_dataset(path,reload_idx);

        case 10
            path='C:\MATLAB\Dataset\TST\Data';
            base_joint_center=1;
            base_joint_left=5;
            base_joint_right=9;
            joint_pair=[ 1  2  3  3  3  5  6   9 10   1  1 13 14  17 18 ;
                2  3  4  5  9  6  7  10 11  13 17 14 15  18 19 ];
            % joint_num=[4,8,12,14,16,18,20];
            joint_num=1:20;
            joint_pair_begin=[];
            joint_pair_end=[];
            scaling_joints=[3,13,17];
            [skeleton,number_of_samples,action_length]=load_TST_dataset(path,reload_idx);

        case {11,12,13,14}
            dataset_idx = dataset_idx-10;
            path='C:\MATLAB\Dataset\MSRAction3D\';
            base_joint_center=7;
            base_joint_left=1;
            base_joint_right=2;
            joint_pair=[20  1  2  1  8 10  2  9 11  3  4  7  7  5  6 14 15 16 17;
                3  3  3  8 10 12  9 11 13  4  7  5  6 14 15 16 17 18 19];
            % joint_num=[10,11,12,13,16,17,20];
            joint_num=1:20;
            joint_pair_begin=[8,10,1,2];
            joint_pair_end=[9,11,14,15];
            scaling_joints=[3,6,5];
            [skeleton,number_of_samples,action_length]=load_MSRAction3D_dataset(dataset_idx,path,reload_idx);

        case 15
            path='C:\MATLAB\Dataset\MSRDailyActivity\Data';
            base_joint_center=1;
            base_joint_left=5;
            base_joint_right=9;
            joint_pair=[ 1  2  3  3  3  5  6  7  9 10 11  1  1 13 14 15 17 18 19;
                2  3  4  5  9  6  7  8 10 11 12 13 17 14 15 16 18 19 20];
            % joint_num=[4,8,12,14,16,18,20];
            joint_num=1:20;
            joint_pair_begin=[6,7,5,9];
            joint_pair_end=[10,11,14,18];
            scaling_joints=[3,13,17];
            [skeleton,number_of_samples,action_length]=load_MSRDailyActivity_dataset(path,reload_idx);

        case 16
            path='C:\MATLAB\Dataset\CAD_120\Data';
            base_joint_center=3;
            base_joint_left=4;
            base_joint_right=6;
            joint_pair=[ 1  2  2  2  4  5  6  7  3  3  8 10  9 11;
                2  3  4  6  5 12  7 13  8 10  9 11 14 15];
            joint_num=[1:7,12:13];
%             joint_num=1:20;
            joint_pair_begin=[5,12];
            joint_pair_end=[7,13];
            scaling_joints=[2,8,10];
            [skeleton,number_of_samples,action_length]=load_CAD_120_dataset(path,reload_idx);
    end

end
