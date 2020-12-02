function [] = save_to_file( name,signals,actions,subjects,subsignals )
    disp('		Saving Debug Files...');
    
%% save data as vectors
    cd('debug')
    cd('matrices')
    
    % save feature matrices
%     fid=fopen(sprintf('%s.txt',name),'wt');
%     for i=1:size(signals,1)
%         fprintf(fid,'action=%d\n',i);
%         for j=1:size(signals,2)
%             fprintf(fid,'\tnum=%d\n',j);
%             for k=1:size(signals,3)
%                 fprintf(fid,'\t\tsubsignal=%d\t',k);
%                 for l=1:size(signals,4)
%                     fprintf(fid,'%.2f\t',signals(i,j,k,l));
%                 end
%                 fprintf(fid,'\n');
%             end
%             fprintf(fid,'\n');
%         end
%         fprintf(fid,'\n');
%     end
%     fclose(fid);
    
    cd('..')
    cd('..')

%% save data as plots 
    cd('debug')
    cd('figures')
    
    framenum=zeros(size(signals,4),1);
    for i=1:size(signals,4)
        framenum(i,1)=i;
    end
    for i=actions
        for j=subjects
            for k=subsignals
                figure('visible','off')
                plot(framenum,permute(signals(i,j,k,:),[4 3 2 1]));
                saveas(gcf,sprintf('%s action%d number%d subsignal%d',name,i,j,k),'jpg');
            end
        end
    end
    
    cd('..')
    cd('..')

end
