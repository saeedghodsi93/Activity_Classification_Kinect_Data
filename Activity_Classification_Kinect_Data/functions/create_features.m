function [ train_features,test_features ] = create_features( template_lengths,train_warped,test_warped,wavelet_name,wavelet_level,active_subsignals,debug )
    disp('	Creating Features...');
    
    cutoff = 1.0;

    train_features = zeros(size(train_warped,1),[]);
    for i=1:size(train_warped,1)
        feature = zeros(size(train_warped,2),size(train_warped,3),[]);
        length = zeros(size(train_warped,2),size(train_warped,3));
        for j=1:size(train_warped,2)
            for k=1:size(train_warped,3)
                [c,l] = wavedec(train_warped(i,j,k,1:template_lengths(j,k)),wavelet_level,wavelet_name);
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
        
%         if i==10
%             draw_features(feature,length,train_features);
%         end
        
    end
%     temp_feature = zeros(size(feature));
%     temp_length = zeros(size(length));
%     for i=1:size(feature,1)
%         for j=1:size(feature,2)
%             num=0;
%             for k=1:size(feature,3)
%                 if active_subsignals(j,k)==1
%                     num = num + 1;
%                     temp_feature(i,j,num,:) = feature(i,j,k,:);
%                     temp_length(j,num) = length(j,k);
%                 end
%             end
%         end
%     end
%     feature = temp_feature;
%     length = temp_length;
    
    % save results for debug (time consuming)
    if debug==1
        save_to_file('train features',feature,[1:2],[1:2],1:30); 
    end
    
    test_features = zeros(size(test_warped,1),[]);
    for i=1:size(test_warped,1)
        feature = zeros(size(test_warped,2),size(test_warped,3),[]);
        length = zeros(size(test_warped,2),size(test_warped,3));
        for j=1:size(test_warped,2)
            for k=1:size(test_warped,3)
                [c,l] = wavedec(test_warped(i,j,k,1:template_lengths(j,k)),wavelet_level,wavelet_name);
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
    end
%     temp_feature = zeros(size(feature));
%     temp_length = zeros(size(length));
%     for i=1:size(feature,1)
%         for j=1:size(feature,2)
%             num=0;
%             for k=1:size(feature,3)
%                 if active_subsignals(j,k)==1
%                     num = num + 1;
%                     temp_feature(i,j,num,:) = feature(i,j,k,:);
%                     temp_length(j,num) = length(j,k);
%                 end
%             end
%         end
%     end
%     feature = temp_feature;
%     length = temp_length;
    
    % save results for debug (time consuming)
    if debug==1
        save_to_file('test features',feature,[1],[1:10],4:9); 
    end
    
end
