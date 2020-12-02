function [ confusion_matrix ] = classification( train_features,train_labels,test_features,test_labels,confusion_matrix )
    disp('	Classification...');
    
%     p = zeros(1,size(train_features,2));
%     for i=1:size(train_features,2)
%         p(1,i) = anova1(train_features(:,i),train_labels,'off');
%     end
%     [sorted_p,sorted_p_idx] = sort(p,2);
%     threshold=1e-10;
%     dim=find(cumsum(sorted_p)>threshold,1,'first');
%     display(dim);
%     selectedIndices = sorted_p_idx(1:dim);
%     train_features=train_features(:,selectedIndices);
%     test_features=test_features(:,selectedIndices);

    options = statset('UseParallel',false);
%     classifier=fitcdiscr(train_features,train_labels,'DiscrimType','linear');
%     classifier=fitcknn(train_features,train_labels,'NumNeighbors',1,'Distance','euclidean');
%     classifier=fitcknn(train_features,train_labels,'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',struct('AcquisitionFunctionName','expected-improvement-plus'));
%     t = templateNaiveBayes('Distribution','normal');
%     t = templateSVM('KernelFunction','linear');
%     classifier=fitcecoc(train_features,train_labels,'Learners',t,'Options',options);
%     classifier=fitensemble(train_features,train_labels,'Bag',300,'Tree','Type','Classification');
    classifier=TreeBagger(300,train_features,train_labels,'OOBPrediction','Off','Method','classification','Options',options,'Prior','Uniform');
    predicted_labels=predict(classifier,test_features);
    
    if(iscell(predicted_labels))
        predicted_labels=cellfun(@str2num,predicted_labels);
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
