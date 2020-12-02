function [ average_accuracy,average_precision,average_recall ]=result( confusion_matrix,dataset_idx,cross_validation_idx )
    
    % recognition rates
    average_accuracy=0;
    accuracy=zeros(size(confusion_matrix,1),1);
    precision=zeros(size(confusion_matrix,1),1);
    recall=zeros(size(confusion_matrix,1),1);
    for i=1:size(confusion_matrix,1)
        true_positive=confusion_matrix(i,i);
        true_negative=0;
        for j=1:size(confusion_matrix,1)
            for k=1:size(confusion_matrix,2)
                if(j~=i && k~=i)
                    true_negative=true_negative+confusion_matrix(j,k);
                end
            end
        end
        false_positive=0;
        for j=1:size(confusion_matrix,1)
            if(j~=i)
                false_positive=false_positive+confusion_matrix(j,i);
            end
        end
        false_negative=0;
        for j=1:size(confusion_matrix,2)
            if(j~=i)
                false_negative=false_negative+confusion_matrix(i,j);
            end
        end
        positive=true_positive+false_negative;
        negative=true_negative+false_positive;
        average_accuracy=average_accuracy+confusion_matrix(i,i);
        if (true_positive+true_negative)==0
            accuracy(i)=0;
        else
            accuracy(i)=(true_positive+true_negative)/(positive+negative);
        end
        if (true_positive)==0
            precision(i)=0;
            recall(i)=0;
        else
            precision(i)=(true_positive)/(true_positive+false_positive);
            recall(i)=(true_positive)/(true_positive+false_negative);
        end
    end
    average_accuracy=average_accuracy/sum(sum(confusion_matrix));
    average_precision=mean(precision);
    average_recall=mean(recall);  
    
    % save results to file
    cd('results')
    switch dataset_idx
        case {1,2,3,4,5,6}
            cd('CAD')
            switch dataset_idx
                case 1
                    cd('Bathroom')
                case 2
                    cd('Bedroom')
                case 3
                    cd('Kitchen')
                case 4
                    cd('Living Room')
                case 5
                    cd('Office')
                case 6
                    cd('Overall')
            end
        case 7
            cd('UTKinect')
        case 8
            cd('UCFKinect')
        case 9
			cd('Florence3D')
        case 10    
            cd('TST')
        case {11,12,13,14}
            cd('MSRAction3D')
            switch dataset_idx-11
                case 1
                    cd('AS1')
                case 2
                    cd('AS2')
                case 3
                    cd('AS3')
                case 4
                    cd('Overall')
            end
        case 15
            cd('MSRDailyActivity')
        case 16
            cd('CAD_120')
    end
    
    switch cross_validation_idx
        case 1
            cross_validation='Leave-One-Out';
        case 2
            cross_validation='Cross-Subject';
        case 3
            cross_validation='4-Fold';
    end
    
    fid=fopen(sprintf('%s.txt',cross_validation),'wt');
    fprintf(fid,'\nAverage Accuracy=\n\t%.3f\n',average_accuracy);
    fprintf(fid,'\nAverage Precision=\n\t%.3f\n',average_precision);
    fprintf(fid,'\nAverage Recall=\n\t%.3f\n',average_recall);
    fprintf(fid,'\nAccuracy=\n');
    for i=1:size(confusion_matrix,1)
        fprintf(fid,'\t%.2f\n',accuracy(i));
    end
    fprintf(fid,'\nPrecision=\n');
    for i=1:size(confusion_matrix,1)
        fprintf(fid,'\t%.2f\n',precision(i));
    end
    fprintf(fid,'\nRecall=\n');
    for i=1:size(confusion_matrix,1)
        fprintf(fid,'\t%.2f\n',recall(i));
    end
    fprintf(fid,'\nConfusion Matrix=\n');
    for i=1:size(confusion_matrix,1)
        fprintf(fid,'[');
        confusion_matrix(i,:)=confusion_matrix(i,:) / sum(confusion_matrix(i,:));
        for j=1:(size(confusion_matrix,2)-1)
            fprintf(fid,'%.1f,',100*confusion_matrix(i,j));
        end
        fprintf(fid,'%.1f],\n',100*confusion_matrix(i,size(confusion_matrix,2)));
    end
    fclose(fid);
    if (dataset_idx>=1 && dataset_idx<=6) || (dataset_idx>=11 && dataset_idx<=14)
        cd('..')
    end
    cd('..')
    cd('..')
    
    display(average_accuracy);
    display(average_precision);
    display(average_recall);
    
    disp('Done!');
    
end
