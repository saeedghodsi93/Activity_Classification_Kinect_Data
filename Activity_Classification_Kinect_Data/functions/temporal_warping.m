function [ train_warped,test_warped ] = temporal_warping( template_signals,template_lengths,train_signals,train_lengths,test_signals,test_lengths,warping_window_size,debug )
    disp('	Temporal Warping...');
    
    train_warped = zeros(size(train_signals,1),size(template_signals,1),size(template_signals,2),[]);
    for i=1:size(train_signals,1)
        for j=1:size(template_signals,1) 
            for k=1:size(template_signals,2)
                train_subsignal_length = train_lengths(i);
                template_subsignal_length = template_lengths(j,k);   
                train_subsignal = permute(train_signals(i,k,1:train_subsignal_length),[1 3 2]);
                template_subsignal = permute(template_signals(j,k,1:template_subsignal_length),[1 3 2]);
                window_size = max([abs(train_subsignal_length-template_subsignal_length),ceil(warping_window_size*max([train_subsignal_length,template_subsignal_length]))]);
                [~,train_subsignal_path,template_subsignal_path] = dtw(train_subsignal,template_subsignal,window_size);
				iterator = 1;
                for l=1:template_subsignal_length
                    temp = 0;
                    num = 0;
                    while iterator<=size(template_subsignal_path,1) && template_subsignal_path(iterator,1)==l
                        temp = temp + train_subsignal(1,train_subsignal_path(iterator),1,1);
                        num = num + 1;
                        iterator = iterator + 1;
                    end
                    if num~=0
                        train_warped(i,j,k,l) = temp/num;
                    else
                        train_warped(i,j,k,l) = train_warped(i,j,k,l-1);
                    end
                end
            end
        end
    end
    
%     draw_warped(train_signals,train_lengths,train_warped,template_lengths);
    
    % save results for debug (time consuming)
    if debug==1
        save_to_file('train warped',train_warped,[1],[1:10],4:9);
    end
    
    test_warped = zeros(size(test_signals,1),size(template_signals,1),size(template_signals,2),[]);
    for i=1:size(test_signals,1)
        for j=1:size(template_signals,1)
            for k=1:size(template_signals,2)
                test_subsignal_length = test_lengths(i);
                template_subsignal_length = template_lengths(j,k);
                test_subsignal = permute(test_signals(i,k,1:test_subsignal_length),[1 3 2]);
                template_subsignal = permute(template_signals(j,k,1:template_subsignal_length),[1 3 2]);
                window_size = max([abs(test_subsignal_length-template_subsignal_length),ceil(warping_window_size*max([test_subsignal_length,template_subsignal_length]))]);
                [~,test_subsignal_path,template_subsignal_path] = dtw(test_subsignal,template_subsignal,window_size);
				iterator = 1;
                for l=1:template_subsignal_length
                    temp = 0;
                    num = 0;
                    while iterator<=size(template_subsignal_path,1) && template_subsignal_path(iterator,1)==l
                        temp = temp + test_subsignal(1,test_subsignal_path(iterator),1,1);
                        num = num + 1;
                        iterator = iterator + 1;
                    end
                    if num~=0
                        test_warped(i,j,k,l) = temp/num;
                    else
                        test_warped(i,j,k,l) = test_warped(i,j,k,l-1);
                    end
                end
            end
        end
    end
    
    % save results for debug (time consuming)
    if debug==1
        save_to_file('test warped',test_warped,[4],[1:10],4:9); 
    end
    
end
