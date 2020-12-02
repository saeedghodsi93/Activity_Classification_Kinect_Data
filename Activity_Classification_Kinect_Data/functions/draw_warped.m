function [  ] = draw_warped( train_signals,train_lengths,train_warped,template_lengths )

    marker='o';
    marker_size=3;
    wave_color1=[208,32,144];
    wave_color2=[255,148,25];
    wave_color3=[107,142,35];

    sample=10;
    
    % Original sample
    h=figure;
    hold on;
    t=1:train_lengths(sample);
    subsignal=11;
    y1=permute(train_signals(sample,subsignal,1:train_lengths(sample)),[2 3 1]);
    subsignal=36;
    y2=permute(train_signals(sample,subsignal,1:train_lengths(sample)),[2 3 1]);
    subsignal=54;
    y3=permute(train_signals(sample,subsignal,1:train_lengths(sample)),[2 3 1]);
    plot(t,y1,'marker',marker,'markersize',marker_size,'color',wave_color1/256);
    plot(t,y2,'marker',marker,'markersize',marker_size,'color',wave_color2/256);
    plot(t,y3,'marker',marker,'markersize',marker_size,'color',wave_color3/256);
    set(gca,'XTick',[0 50 100 150]);     set(gca,'YTick',[-40 -20 0 20 40 60 80 100]);     xlim([0 160]);     ylim([-60 120]);     
    title('"Original Sample"');     legend('Head - Height','Right Hand - Depth','Right Knee - Depth','Location','east');     xlabel('Time (frames)');     ylabel('Value (cm)');
    set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(h,'sample','-dpdf','-r0');
    
    % Warped samples
%     h=figure;
%     hold on;
%     template=1;
%     colors=hsv(size(train_warped,3));
%     for subsignal=1:size(train_warped,3)
%         t=1:template_lengths(template,subsignal);
%         y=permute(train_warped(sample,template,subsignal,1:template_lengths(template,subsignal)),[3 4 1 2]);
%         plot(t,y,'marker',marker,'markersize',marker_size,'color',colors(subsignal,:));
%     end
%     set(gca,'XTick',[0 20 40 60 80 100]);     set(gca,'YTick',[-100 -80 -60 -40 -20 0 20 40 60 80]);     xlim([0 110]);     ylim([-110 90]);     
%     title('"Test Sample, Warped with the Template of Action 1"');     xlabel('Time (frames)');     ylabel('Value (cm)');
%     set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%     print(h,'warped_sample','-dpdf','-r0');
    
    h=figure;
    hold on;
    template=1;
    subsignal=11;
    t1=1:template_lengths(template,subsignal);
    y1=permute(train_warped(sample,template,subsignal,1:template_lengths(template,subsignal)),[3 4 1 2]);
    subsignal=36;
    t2=1:template_lengths(template,subsignal);
    y2=permute(train_warped(sample,template,subsignal,1:template_lengths(template,subsignal)),[3 4 1 2]);
    subsignal=54;
    t3=1:template_lengths(template,subsignal);
    y3=permute(train_warped(sample,template,subsignal,1:template_lengths(template,subsignal)),[3 4 1 2]);
    plot(t1,y1,'marker',marker,'markersize',marker_size,'color',wave_color1/256);
    plot(t2,y2,'marker',marker,'markersize',marker_size,'color',wave_color2/256);
    plot(t3,y3,'marker',marker,'markersize',marker_size,'color',wave_color3/256);
    set(gca,'XTick',[0 20 40 60 80]);     set(gca,'YTick',[-40 -20 0 20 40 60 80 100]);     xlim([0 100]);     ylim([-60 120]);     
    title('"Warping with the Template of Action 1"');     legend('Head - Height','Right Hand - Depth','Right Knee - Depth','Location','east');     xlabel('Time (frames)');     ylabel('Value (cm)');
    set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(h,'warped_sample1','-dpdf','-r0');
    
    h=figure;
    hold on;
    template=4;
    subsignal=11;
    t1=1:template_lengths(template,subsignal);
    y1=permute(train_warped(sample,template,subsignal,1:template_lengths(template,subsignal)),[3 4 1 2]);
%     for i=1:size(y1,2)
%         y1(1,i)=160-y1(1,i);
%     end
    subsignal=36;
    t2=1:template_lengths(template,subsignal);
    y2=permute(train_warped(sample,template,subsignal,1:template_lengths(template,subsignal)),[3 4 1 2]);
%     for i=1:size(y2,2)
%         if y2(1,i)<=-38
%             y2(1,i)=y2(1,i)+15;
%         end
%     end
%     for i=1:size(y2,2)
%         if y2(1,i)<=-25
%             y2(1,i)=-50-y2(1,i);
%         end
%     end
    subsignal=54;
    t3=1:template_lengths(template,subsignal);
    y3=permute(train_warped(sample,template,subsignal,1:template_lengths(template,subsignal)),[3 4 1 2]);
%     for i=1:size(y3,2)
%         if y3(1,i)<=-40
%             y3(1,i)=y3(1,i)-10;
%         end
%     end
    plot(t1,y1,'marker',marker,'markersize',marker_size,'color',wave_color1/256);
    plot(t2,y2,'marker',marker,'markersize',marker_size,'color',wave_color2/256);
    plot(t3,y3,'marker',marker,'markersize',marker_size,'color',wave_color3/256);
    set(gca,'XTick',[0 50 100 150]);     set(gca,'YTick',[-40 -20 0 20 40 60 80 100]);     xlim([0 180]);     ylim([-60 120]);     
    title('"Warping with the Template of Action C"');     legend('Head - Height','Right Hand - Depth','Right Knee - Depth','Location','east');     xlabel('Time (frames)');     ylabel('Value (cm)');
    set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(h,'warped_sampleC','-dpdf','-r0');
    
%     error('fake');
    
end
