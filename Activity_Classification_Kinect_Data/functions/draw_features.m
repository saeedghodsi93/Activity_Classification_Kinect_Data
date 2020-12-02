function [  ] = draw_features( feature,length,train_features )

    marker='o';
    marker_size=3;
    wave_color1=[208,32,144];
    wave_color2=[255,148,25];
    wave_color3=[107,142,35];
    wave_color=[56,142,142];
        
    % Feature vectors
%     h=figure;
%     hold on;
%     template=5;
%     colors=hsv(size(feature,2));
%     for subsignal=1:size(feature,2)
%         t=1:length(template,subsignal);
%         y=permute(feature(template,subsignal,1:length(template,subsignal)),[2 3 1]);
%         plot(t,y,'marker',marker,'markersize',marker_size,'color',colors(subsignal,:));
%     end
%     set(gca,'XTick',[0 20 40 60 80 100 120]);     set(gca,'YTick',[-120 -100 -80 -60 -40 -20 0 20 40 60 80 100]);     xlim([0 130]);     ylim([-130 110]);     
%     title('Feature Vector 1');     xlabel('Feature');     ylabel('Value');
%     set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%     print(h,'feature','-dpdf','-r0');

    h=figure;
    hold on;
    template=1;
    subsignal=11;
    t1=1:length(template,subsignal);
    y1=permute(feature(template,subsignal,1:length(template,subsignal)),[2 3 1]);
    subsignal=36;
    t2=1:length(template,subsignal);
    y2=permute(feature(template,subsignal,1:length(template,subsignal)),[2 3 1]);
    subsignal=54;
    t3=1:length(template,subsignal);
    y3=permute(feature(template,subsignal,1:length(template,subsignal)),[2 3 1]);
    plot(t1,y1,'marker',marker,'markersize',marker_size,'color',wave_color1/256);
    plot(t2,y2,'marker',marker,'markersize',marker_size,'color',wave_color2/256);
    plot(t3,y3,'marker',marker,'markersize',marker_size,'color',wave_color3/256);
    set(gca,'XTick',[0 50 100 150]);     set(gca,'YTick',[-60 -40 -20 0 20 40 60 80 100]);     xlim([0 200]);     ylim([-80 120]);     
    title('"Wavelet Decomposition Output 1"');     legend('Head - Height','Right Hand - Depth','Right Knee - Depth','Location','best');     xlabel('Feature');     ylabel('Value');
    set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(h,'wavelet1','-dpdf','-r0');
    
    h=figure;
    hold on;
    template=4;
    subsignal=11;
    t1=1:length(template,subsignal);
    y1=permute(feature(template,subsignal,1:length(template,subsignal)),[2 3 1]);
%     for i=1:size(y1,2)
%         if y1(1,i)>80
%             y1(1,i)=200-y1(1,i);
%         end
%     end
    subsignal=36;
    t2=1:length(template,subsignal);
    y2=permute(feature(template,subsignal,1:length(template,subsignal)),[2 3 1]);
%     for i=1:size(y2,2)
%         if y2(1,i)<=-55
%             y2(1,i)=y2(1,i)+15;
%         end
%     end
%     for i=1:size(y2,2)
%         if y2(1,i)<=-40
%             y2(1,i)=-80-y2(1,i);
%         end
%     end
    subsignal=54;
    t3=1:length(template,subsignal);
    y3=permute(feature(template,subsignal,1:length(template,subsignal)),[2 3 1]);
    plot(t1,y1,'marker',marker,'markersize',marker_size,'color',wave_color1/256);
    plot(t2,y2,'marker',marker,'markersize',marker_size,'color',wave_color2/256);
    plot(t3,y3,'marker',marker,'markersize',marker_size,'color',wave_color3/256);
    set(gca,'XTick',[0 50 100 150 200 250]);     set(gca,'YTick',[-60 -40 -20 0 20 40 60 80 100]);     xlim([0 275]);     ylim([-80 120]);     
    title('"Wavelet Decomposition Output C"');     legend('Head - Height','Right Hand - Depth','Right Knee - Depth','Location','best');     xlabel('Feature');     ylabel('Value');
    set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(h,'waveletC','-dpdf','-r0');
    
    % Partial feature vectors
    h=figure;
    hold on;
    template=1;
    colors=hsv(size(feature,2));
    t=1:sum(length(template,:));
    y=zeros(1,sum(length(template,:)));
    for subsignal=1:size(feature,2)
        if subsignal==1
            l=0;
        else
            l=sum(length(template,1:subsignal-1));
        end
        y(1,l:l+length(template,subsignal))=permute(feature(template,subsignal,1:length(template,subsignal)),[2 3 1]);
        plot(t,y,'marker',marker,'markersize',marker_size,'color',colors(subsignal,:));
    end
    %set(gca,'XTick',[0 20 40 60 80 100 120]);     set(gca,'YTick',[-120 -100 -80 -60 -40 -20 0 20 40 60 80 100]);     xlim([0 130]);     ylim([-130 110]);     
    title('"Partial Feature Vector 1"');     xlabel('Feature');     ylabel('Value');
    set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(h,'feature','-dpdf','-r0');

    h=figure;
    hold on;
    template=4;
    colors=hsv(size(feature,2));
    t=1:sum(length(template,:));
    y=zeros(1,sum(length(template,:)));
    for subsignal=1:size(feature,2)
        if subsignal==1
            l=0;
        else
            l=sum(length(template,1:subsignal-1));
        end
        y(1,l:l+length(template,subsignal))=permute(feature(template,subsignal,1:length(template,subsignal)),[2 3 1]);
        plot(t,y,'marker',marker,'markersize',marker_size,'color',colors(subsignal,:));
    end
    %set(gca,'XTick',[0 20 40 60 80 100 120]);     set(gca,'YTick',[-120 -100 -80 -60 -40 -20 0 20 40 60 80 100]);     xlim([0 130]);     ylim([-130 110]);     
    title('"Partial Feature Vector C"');     xlabel('Feature');     ylabel('Value');
    set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(h,'feature','-dpdf','-r0');
    
    % Feature vector
    h=figure('units','normalized','outerposition',[0 0 1 1]);
    hold on;
    sample=10;
    t=1:size(train_features,2);
    y=permute(train_features(sample,1:size(train_features,2)),[1 2]);
    plot(t,y,'marker',marker,'markersize',marker_size,'color',wave_color/255);
%     pbaspect([2 1 1]);
%     set(gca,'XTick',[0 50 100 150 200 250]);     set(gca,'YTick',[-60 -40 -20 0 20 40 60 80 100]);     xlim([0 1.1e5]);     ylim([-150 120]);     
    title('"Total Feature Vector"');     xlabel('Feature');     ylabel('Value');
    set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(h,'feature','-dpdf','-r600');
    
    error('fake');
    
end
