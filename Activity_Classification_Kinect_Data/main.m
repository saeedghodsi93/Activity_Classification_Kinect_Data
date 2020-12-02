
    % reset
    clc
    clear all
    close all

    % functions path
    addpath(sprintf('%s',strcat(pwd,'\functions')));

    % set parameters
    datasetIdx=[ 10 ]; % 1-6:CAD, 7:UTKinect, 8:UCFKinect, 9:Florence3D, 10:TST, 11-14:MSRAction3D, 15:MSRDailyActivity 16:CAD-120
    crossValidationIdx=[ 1 ]; % 1:leave-one-out, 2:cross-subject, 3:4-fold
    alignmentIdx=[ 3 ]; % 1:no alignment, 2:action alignment, 3:frame alignment, 4:fusion
    smoothingWindowSize=[ 1 ]; % integer:smoothing window size
    warpingWindowSize=[ 0.1 ]; % 0-1:warping window size

    % run algorithm
    test_idx=0;
    test_size=size(datasetIdx,2)*size(crossValidationIdx,2)*size(alignmentIdx,2)*size(warpingWindowSize,2);
    accuracy=zeros(test_size,1);
    precision=zeros(test_size,1);
    recall=zeros(test_size,1);
    for dataset_idx=datasetIdx
        for cross_validation_idx=crossValidationIdx
            for alignment_idx=alignmentIdx
                for smoothing_window_size=smoothingWindowSize
                    for warping_window_size=warpingWindowSize
                        test_idx=test_idx+1;
                        [average_accuracy,average_precision,average_recall]=run(dataset_idx,cross_validation_idx,alignment_idx,smoothing_window_size,warping_window_size);
                        accuracy(test_idx,1)=average_accuracy;
                        precision(test_idx,1)=average_precision;
                        recall(test_idx,1)=average_recall;
                    end
                end
            end
        end
    end
