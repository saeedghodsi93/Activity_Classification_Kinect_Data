function [ train_features,test_features ] = create_features_CAD(template_lengths_right_handed,template_lengths_left_handed,train_warped_right_handed_right_handed,train_warped_right_handed_left_handed,train_warped_left_handed_right_handed,train_warped_left_handed_left_handed,test_warped_right_handed,test_warped_left_handed,wavelet_name,wavelet_level,active_subsignals_right_handed,active_subsignals_left_handed,debug )
    disp('	Creating Features...');
    
    cutoff = 1.0;
    
    train_features = zeros(size(train_warped_right_handed_right_handed,1)+size(train_warped_left_handed_right_handed,1),[]);
    
    for i=1:size(train_warped_right_handed_right_handed,1)
        feature = zeros(size(train_warped_right_handed_right_handed,2),size(train_warped_right_handed_right_handed,3),[]);
        length = zeros(size(train_warped_right_handed_right_handed,2),size(train_warped_right_handed_right_handed,3));
        for j=1:size(train_warped_right_handed_right_handed,2)
            for k=1:size(train_warped_right_handed_right_handed,3)
                [c,l] = wavedec(permute(train_warped_right_handed_right_handed(i,j,k,1:template_lengths_right_handed(j,k)),[3 4 1 2]),wavelet_level,wavelet_name);
                l = sum(l(1,1:wavelet_level+1));
                feature(j,k,1:l) = c;
                length(j,k) = floor(cutoff*l);
            end
        end
        for j=1:size(feature,1)
            for k=1:size(feature,2)
                train_features(i,sum(sum(length(1:j-1,:)))+sum(length(j,1:k-1))+1:sum(sum(length(1:j-1,:)))+sum(length(j,1:k-1))+length(j,k)) = feature(j,k,1:length(j,k));
            end
        end
        right_right_length = sum(sum(length(:,:)));
        feature = zeros(size(train_warped_right_handed_left_handed,2),size(train_warped_right_handed_left_handed,3),[]);
        length = zeros(size(train_warped_right_handed_left_handed,2),size(train_warped_right_handed_left_handed,3));
        for j=1:size(train_warped_right_handed_left_handed,2)
            for k=1:size(train_warped_right_handed_left_handed,3)
                [c,l] = wavedec(permute(train_warped_right_handed_left_handed(i,j,k,1:template_lengths_left_handed(j,k)),[3 4 1 2]),wavelet_level,wavelet_name);
                l = sum(l(1,1:wavelet_level+1));
                feature(j,k,1:l) = c;
                length(j,k) = floor(cutoff*l);
            end
        end
        for j=1:size(feature,1)
            for k=1:size(feature,2)
                train_features(i,right_right_length+sum(sum(length(1:j-1,:)))+sum(length(j,1:k-1))+1:right_right_length+sum(sum(length(1:j-1,:)))+sum(length(j,1:k-1))+length(j,k)) = feature(j,k,1:length(j,k));
            end
        end
    end
    
    for i=1:size(train_warped_left_handed_right_handed,1)
        feature = zeros(size(train_warped_left_handed_right_handed,2),size(train_warped_left_handed_right_handed,3),[]);
        length = zeros(size(train_warped_left_handed_right_handed,2),size(train_warped_left_handed_right_handed,3));
        for j=1:size(train_warped_left_handed_right_handed,2)
            for k=1:size(train_warped_left_handed_right_handed,3)
                [c,l] = wavedec(permute(train_warped_left_handed_right_handed(i,j,k,1:template_lengths_right_handed(j,k)),[3 4 1 2]),wavelet_level,wavelet_name);
                l = sum(l(1,1:wavelet_level+1));
                feature(j,k,1:l) = c;
                length(j,k) = floor(cutoff*l);
            end
        end
        for j=1:size(feature,1)
            for k=1:size(feature,2)
                train_features(size(train_warped_right_handed_right_handed,1)+i,sum(sum(length(1:j-1,:)))+sum(length(j,1:k-1))+1:sum(sum(length(1:j-1,:)))+sum(length(j,1:k-1))+length(j,k)) = feature(j,k,1:length(j,k));
            end
        end
        right_left_length = sum(sum(length(:,:)));
        feature = zeros(size(train_warped_left_handed_left_handed,2),size(train_warped_left_handed_left_handed,3),[]);
        length = zeros(size(train_warped_left_handed_left_handed,2),size(train_warped_left_handed_left_handed,3));
        for j=1:size(train_warped_left_handed_left_handed,2)
            for k=1:size(train_warped_left_handed_left_handed,3)
                [c,l] = wavedec(permute(train_warped_left_handed_left_handed(i,j,k,1:template_lengths_left_handed(j,k)),[3 4 1 2]),wavelet_level,wavelet_name);
                l = sum(l(1,1:wavelet_level+1));
                feature(j,k,1:l) = c;
                length(j,k) = floor(cutoff*l);
            end
        end
        for j=1:size(feature,1)
            for k=1:size(feature,2)
                train_features(size(train_warped_right_handed_right_handed,1)+i,right_left_length+sum(sum(length(1:j-1,:)))+sum(length(j,1:k-1))+1:right_left_length+sum(sum(length(1:j-1,:)))+sum(length(j,1:k-1))+length(j,k)) = feature(j,k,1:length(j,k));
            end
        end
    end
        
    test_features = zeros(size(test_warped_right_handed,1),[]);
    
    for i=1:size(test_warped_right_handed,1)
        feature = zeros(size(test_warped_right_handed,2),size(test_warped_right_handed,3),[]);
        length = zeros(size(test_warped_right_handed,2),size(test_warped_right_handed,3));
        for j=1:size(test_warped_right_handed,2)
            for k=1:size(test_warped_right_handed,3)
                [c,l] = wavedec(permute(test_warped_right_handed(i,j,k,1:template_lengths_right_handed(j,k)),[3 4 1 2]),wavelet_level,wavelet_name);
                l = sum(l(1,1:wavelet_level+1));
                feature(j,k,1:l) = c;
                length(j,k) = floor(cutoff*l);
            end
        end
        for j=1:size(feature,1)
            for k=1:size(feature,2)
                test_features(i,sum(sum(length(1:j-1,:)))+sum(length(j,1:k-1))+1:sum(sum(length(1:j-1,:)))+sum(length(j,1:k-1))+length(j,k)) = feature(j,k,1:length(j,k));
            end
        end
        right_length = sum(sum(length(:,:)));
        feature = zeros(size(test_warped_left_handed,2),size(test_warped_left_handed,3),[]);
        length = zeros(size(test_warped_left_handed,2),size(test_warped_left_handed,3));
        for j=1:size(test_warped_left_handed,2)
            for k=1:size(test_warped_left_handed,3)
                [c,l] = wavedec(permute(test_warped_left_handed(i,j,k,1:template_lengths_left_handed(j,k)),[3 4 1 2]),wavelet_level,wavelet_name);
                l = sum(l(1,1:wavelet_level+1));
                feature(j,k,1:l) = c;
                length(j,k) = floor(cutoff*l);
            end
        end
        for j=1:size(feature,1)
            for k=1:size(feature,2)
                test_features(i,right_length+sum(sum(length(1:j-1,:)))+sum(length(j,1:k-1))+1:right_right_length+sum(sum(length(1:j-1,:)))+sum(length(j,1:k-1))+length(j,k)) = feature(j,k,1:length(j,k));
            end
        end
    end
    
    % save results for debug (time consuming)
    if debug==1
        save_to_file('warped_right_handed_right_handed',train_warped_right_handed_right_handed,[1],[1 2],1:9);
        save_to_file('warped_right_handed_left_handed',train_warped_right_handed_left_handed,[1],[1 2],1:9);
        %save_to_file('warped_left_handed_right_handed',train_warped_left_handed_right_handed,[1],[1 2],1:9);
        %save_to_file('warped_left_handed_left_handed',train_warped_left_handed_left_handed,[1],[1 2],1:9);
    end
    
end
