function [ train_observations,test_observations ] = dimensionality_reduction( dimension_idx,train_observations,test_observations,train_labels,number_of_actions )

    if dimension_idx==1
        % do nothing
        
    elseif dimension_idx==2
        disp('	Performing PCA...');
    
%         % normalization
%         train_observations_normalized = train_observations;
%         for i = 1:size(train_observations_normalized, 2)
%             train_observations_normalized(:,i) = train_observations_normalized(:,i) - nanmean(train_observations_normalized(:,i));
%             train_observations_normalized(:,i) = train_observations_normalized(:,i) / nanstd(train_observations_normalized(:,i));
%         end
%         train_observations=train_observations_normalized;
        
        % PCA for dimensionality reduction
        threshold=98;
        [coeff,~,~,~,explained]=pca(train_observations);
        dim=find(cumsum(explained)>threshold,1,'first');
        train_observations=train_observations*coeff(:,1:dim);
        test_observations=test_observations*coeff(:,1:dim);
        
    elseif dimension_idx==3
        disp('	Feature Selection...');
        
%         selectedIndices = feast('cmim',5,train_observations,train_labels);
%         display(size(selectedIndices));
        
        p = zeros(1,size(train_observations,2));
        for i=1:size(train_observations,2)
            p(1,i) = anova1(train_observations(:,i),train_labels,'off');
        end
        
        [sorted_p,sorted_p_idx] = sort(p,2);
        threshold=1e-10;
        dim=find(cumsum(sorted_p)>threshold,1,'first');
        fs = sorted_p_idx(1:dim);
        selectedIndices = fs;
        display(dim);
        
%         classf=@(XTrain,yTrain,XTest,yTest) (sum(yTest ~= classify(XTest,XTrain,yTrain,'diagLinear')));
%         options = statset('UseParallel',true);
%         fs2=sequentialfs(classf,train_observations(:,fs),train_labels,'cv',10,'nfeatures',20,'options',options);
%         selected=fs(fs2);
%         display(selected);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
%         p = zeros(size(train_observations,2),1);
%         for i=1:size(train_observations,2)
%             action_samples = zeros([],number_of_actions);
%             action_samples_counter = zeros(number_of_actions,1);
%             for j=1:size(train_observations,1)
%                 action_samples_counter(train_labels(j),1) = action_samples_counter(train_labels(j),1) + 1;
%                 action_samples(action_samples_counter(train_labels(j),1),train_labels(j)) = train_observations(j,i); 
%             end
%             p(i,1) = anova1(action_samples,);
%         end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
%         display(selected);
%         train_observations=train_observations(:,selected);
%         test_observations=test_observations(:,selected);

%         testMCE = zeros(1,14);
%         nfs = 5:5:70;
%         classf = @(xtrain,ytrain,xtest,ytest) sum(~strcmp(ytest,classify(xtest,xtrain,ytrain,'quadratic')));
%         for i = 1:14
%            fs = featureIdxSortbyP(1:nfs(i));
%            testMCE(i) = crossval(classf,train_observations(:,fs),train_labels,'partition',holdoutCVP) /;
%         end
%         plot(nfs, testMCE,'o');
%         xlabel('Number of Features');
%         ylabel('MCE');
%         legend({'MCE on the test set'},'location','NW');
%         title('Simple Filter Feature Selection Method');

%         maxdev = chi2inv(.95,1);     
%         opt = statset('display','iter','TolFun',maxdev,'TolTypeFun','abs');
%         inmodel = sequentialfs(@critfun,train_observations,train_labels,'cv','none','nullmodel',true,'options',opt,'direction','forward');
        
%         [~,p]=ttest2(train_observations(1,:),train_observations(2,:),'Vartype','unequal');
%         p
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        train_observations=train_observations(:,selectedIndices);
        test_observations=test_observations(:,selectedIndices);

    end
    
end
