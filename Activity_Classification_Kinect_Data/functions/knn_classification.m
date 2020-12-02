function [ confusion_matrix ] =knn_classification(template_signals_right_handed,template_signals_left_handed,template_lengths,test_signals,test_lengths,test_labels,warping_window_size,confusion_matrix)
    disp('	Classification...');
    
    distances = zeros(size(test_signals,1),size(template_signals_right_handed,1));
    for i=1:size(test_signals,1)
        test_subsignal_length = test_lengths(i);
        for j=1:size(template_signals_right_handed,1)
            subsignals_distance_right_handed = zeros(size(template_signals_right_handed,2),1);
            template_subsignal_length = template_lengths(j);
            for k=1:size(template_signals_right_handed,2)
                test_subsignal = permute(test_signals(i,k,1:test_subsignal_length),[1 3 2]);
                template_subsignal = permute(template_signals_right_handed(j,k,1:template_subsignal_length),[1 3 2]);    
                window_size = max([abs(test_subsignal_length-template_subsignal_length),ceil(warping_window_size*max([test_subsignal_length,template_subsignal_length]))]);
                subsignals_distance_right_handed(k,1) = dtw(test_subsignal,template_subsignal,window_size);
            end
            display(subsignals_distance_right_handed);
            distance_right_handed = norm(subsignals_distance_right_handed);
            subsignals_distance_left_handed = zeros(size(template_signals_left_handed,2),1);
            template_subsignal_length = template_lengths(j);
            for k=1:size(template_signals_left_handed,2)
                test_subsignal = permute(test_signals(i,k,1:test_subsignal_length),[1 3 2]);
                template_subsignal = permute(template_signals_left_handed(j,k,1:template_subsignal_length),[1 3 2]);    
                window_size = max([abs(test_subsignal_length-template_subsignal_length),ceil(warping_window_size*max([test_subsignal_length,template_subsignal_length]))]);
                subsignals_distance_left_handed(k,1) = dtw(test_subsignal,template_subsignal,window_size);
            end
            display(subsignals_distance_right_handed);
            distance_left_handed = norm(subsignals_distance_left_handed);
            distances(i,j) = min(distance_right_handed,distance_left_handed);
        end
    end
    display(distances);
    
    predicted_labels = zeros(size(test_signals,1),1);
    for i=1:size(predicted_labels,1)
        [~,idx] = min(distances(i,:));
        predicted_labels(i,1) = idx;
    end
    
    % update confusion matrix
    for i=1:size(predicted_labels,1)
        if isnan(predicted_labels(i)) || isinf(predicted_labels(i))
            confusion_matrix(test_labels(i),size(confusion_matrix,2))=confusion_matrix(test_labels(i),size(confusion_matrix,2))+1;
        else
            confusion_matrix(test_labels(i),predicted_labels(i))=confusion_matrix(test_labels(i),predicted_labels(i))+1;
        end
    end

end
