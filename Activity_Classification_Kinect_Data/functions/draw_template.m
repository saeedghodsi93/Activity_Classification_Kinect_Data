function [  ] = draw_template( actions,lengths,mean_subsignals,actions_warped,temp_mean )

    marker='o';
    marker_size=3;
    wave_color1=[208,32,144];
    wave_color2=[255,148,25];
    wave_color3=[107,142,35];

    action=1;
    
    % Original samples
%     h=figure;
%     hold on;
%     sample=1;
%     t=1:lengths(action,sample);
%     colors=hsv(size(actions,3));
%     for subsignal=1:size(actions,3)
%         y=permute(actions(action,sample,subsignal,1:lengths(action,sample)),[3 4 1 2]);
%         plot(t,y,'marker',marker,'markersize',marker_size,'color',colors(subsignal,:));
%     end
%     set(gca,'XTick',[0 100 200 300 400]);     set(gca,'YTick',[-100 -80 -60 -40 -20 0 20 40 60 80]);     xlim([0 450]);     ylim([-110 90]);     
%     title('"Test Sample"');     xlabel('Time (frames)');     ylabel('Value (cm)');
%     set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%     print(h,'Sample','-dpdf','-r0');
    
%     h=figure;
%     hold on;
%     sample=17;
%     t=1:lengths(action,sample);
%     subsignal=11;
%     y1=permute(actions(action,sample,subsignal,1:lengths(action,sample)),[3 4 1 2]);
%     subsignal=36;
%     y2=permute(actions(action,sample,subsignal,1:lengths(action,sample)),[3 4 1 2]);
%     subsignal=54;
%     y3=permute(actions(action,sample,subsignal,1:lengths(action,sample)),[3 4 1 2]);
%     plot(t,y1,'marker',marker,'markersize',marker_size,'color',wave_color1/256);
%     plot(t,y2,'marker',marker,'markersize',marker_size,'color',wave_color2/256);
%     plot(t,y3,'marker',marker,'markersize',marker_size,'color',wave_color3/256);
%     set(gca,'XTick',[0 20 40 60 80 100]);     set(gca,'YTick',[-60 -40 -20 0 20 40 60 80 100]);     xlim([0 105]);     ylim([-60 100]);     
%     title('"Sample 1 of Action Sit"');     legend('Head - Height','Right Hand - Depth','Right Knee - Depth','Location','east');     xlabel('Time (frames)');     ylabel('Value (cm)');
%     set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%     print(h,'sample1','-dpdf','-r0');
%     
%     h=figure;
%     hold on;
%     sample=9;
%     t=1:lengths(action,sample);
%     subsignal=11;
%     y1=permute(actions(action,sample,subsignal,1:lengths(action,sample)),[3 4 1 2]);
%     subsignal=36;
%     y2=permute(actions(action,sample,subsignal,1:lengths(action,sample)),[3 4 1 2]);
%     subsignal=54;
%     y3=permute(actions(action,sample,subsignal,1:lengths(action,sample)),[3 4 1 2]);
%     plot(t,y1,'marker',marker,'markersize',marker_size,'color',wave_color1/256);
%     plot(t,y2,'marker',marker,'markersize',marker_size,'color',wave_color2/256);
%     plot(t,y3,'marker',marker,'markersize',marker_size,'color',wave_color3/256);
%     set(gca,'XTick',[0 20 40 60 80 100]);     set(gca,'YTick',[-60 -40 -20 0 20 40 60 80 100]);     xlim([0 105]);     ylim([-60 100]);     
%     title('"Sample N^{Sit} of Action Sit"');     legend('Head - Height','Right Hand - Depth','Right Knee - Depth','Location','east');     xlabel('Time (frames)');     ylabel('Value (cm)');
%     set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%     print(h,'sample2','-dpdf','-r0');
%     
%     h=figure;
%     hold on;
%     sample=22;
%     t=1:lengths(action,sample);
%     subsignal=11;
%     y1=permute(actions(action,sample,subsignal,1:lengths(action,sample)),[3 4 1 2]);
%     subsignal=36;
%     y2=permute(actions(action,sample,subsignal,1:lengths(action,sample)),[3 4 1 2]);
%     subsignal=54;
%     y3=permute(actions(action,sample,subsignal,1:lengths(action,sample)),[3 4 1 2]);
%     plot(t,y1,'marker',marker,'markersize',marker_size,'color',wave_color1/256);
%     plot(t,y2,'marker',marker,'markersize',marker_size,'color',wave_color2/256);
%     plot(t,y3,'marker',marker,'markersize',marker_size,'color',wave_color3/256);
%     set(gca,'XTick',[0 20 40 60 80 100]);     set(gca,'YTick',[-60 -40 -20 0 20 40 60 80 100]);     xlim([0 105]);     ylim([-60 100]);     
%     title('"Sample N^{Sit} of Action Sit"');     legend('Head - Height','Right Hand - Depth','Right Knee - Depth','Location','east');     xlabel('Time (frames)');     ylabel('Value (cm)');
%     set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%     print(h,'sample3','-dpdf','-r0');
%     
%     % Mean sample
%     h=figure;
%     hold on;
%     subsignal=11;
%     sample=mean_subsignals(action,subsignal);
%     t1=1:lengths(action,sample);
%     y1=permute(actions(action,sample,subsignal,1:lengths(action,sample)),[3 4 1 2]);
%     subsignal=36;
%     sample=mean_subsignals(action,subsignal);
%     t2=1:lengths(action,sample);
%     y2=permute(actions(action,sample,subsignal,1:lengths(action,sample)),[3 4 1 2]);
%     subsignal=54;
%     sample=mean_subsignals(action,subsignal);
%     t3=1:lengths(action,sample);
%     y3=permute(actions(action,sample,subsignal,1:lengths(action,sample)),[3 4 1 2]);
%     plot(t1,y1,'marker',marker,'markersize',marker_size,'color',wave_color1/256);
%     plot(t2,y2,'marker',marker,'markersize',marker_size,'color',wave_color2/256);
%     plot(t3,y3,'marker',marker,'markersize',marker_size,'color',wave_color3/256);
%     set(gca,'XTick',[0 20 40 60 80 100]);     set(gca,'YTick',[-60 -40 -20 0 20 40 60 80 100]);     xlim([0 105]);     ylim([-60 100]);     
%     title('"Mean-Sample of Action Sit"');     legend('Head - Height','Right Hand - Depth','Right Knee - Depth','Location','east');     xlabel('Time (frames)');     ylabel('Value (cm)');
%     set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%     print(h,'mean','-dpdf','-r0');
%     
%     % Warped samples
%     h=figure;
%     hold on;
%     sample=17;
%     subsignal=11;
%     t1=1:lengths(action,mean_subsignals(action,subsignal));
%     y1=permute(actions_warped(action,sample,subsignal,1:lengths(action,mean_subsignals(action,subsignal))),[3 4 1 2]);
%     subsignal=36;
%     t2=1:lengths(action,mean_subsignals(action,subsignal));
%     y2=permute(actions_warped(action,sample,subsignal,1:lengths(action,mean_subsignals(action,subsignal))),[3 4 1 2]);
%     subsignal=54;
%     t3=1:lengths(action,mean_subsignals(action,subsignal));
%     y3=permute(actions_warped(action,sample,subsignal,1:lengths(action,mean_subsignals(action,subsignal))),[3 4 1 2]);
%     plot(t1,y1,'marker',marker,'markersize',marker_size,'color',wave_color1/256);
%     plot(t2,y2,'marker',marker,'markersize',marker_size,'color',wave_color2/256);
%     plot(t3,y3,'marker',marker,'markersize',marker_size,'color',wave_color3/256);
%     set(gca,'XTick',[0 20 40 60 80 100]);     set(gca,'YTick',[-60 -40 -20 0 20 40 60 80 100]);     xlim([0 105]);     ylim([-60 100]);     
%     title('"Sample 1, Warped with the Mean-Sample"');     legend('Head - Height','Right Hand - Depth','Right Knee - Depth','Location','east');     xlabel('Time (frames)');     ylabel('Value (cm)');
%     set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%     print(h,'warped1','-dpdf','-r0');
%     
%     h=figure;
%     hold on;
%     sample=9;
%     subsignal=11;
%     t1=1:lengths(action,mean_subsignals(action,subsignal));
%     y1=permute(actions_warped(action,sample,subsignal,1:lengths(action,mean_subsignals(action,subsignal))),[3 4 1 2]);
%     subsignal=36;
%     t2=1:lengths(action,mean_subsignals(action,subsignal));
%     y2=permute(actions_warped(action,sample,subsignal,1:lengths(action,mean_subsignals(action,subsignal))),[3 4 1 2]);
%     subsignal=54;
%     t3=1:lengths(action,mean_subsignals(action,subsignal));
%     y3=permute(actions_warped(action,sample,subsignal,1:lengths(action,mean_subsignals(action,subsignal))),[3 4 1 2]);
%     plot(t1,y1,'marker',marker,'markersize',marker_size,'color',wave_color1/256);
%     plot(t2,y2,'marker',marker,'markersize',marker_size,'color',wave_color2/256);
%     plot(t3,y3,'marker',marker,'markersize',marker_size,'color',wave_color3/256);
%     set(gca,'XTick',[0 20 40 60 80 100]);     set(gca,'YTick',[-60 -40 -20 0 20 40 60 80 100]);     xlim([0 105]);     ylim([-60 100]);     
%     title('"Sample N^{Sit}, Warped with the Mean-Sample"');     legend('Head - Height','Right Hand - Depth','Right Knee - Depth','Location','east');     xlabel('Time (frames)');     ylabel('Value (cm)');
%     set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%     print(h,'warped2','-dpdf','-r0');
%     
%     h=figure;
%     hold on;
%     sample=22;
%     subsignal=11;
%     t1=1:lengths(action,mean_subsignals(action,subsignal));
%     y1=permute(actions_warped(action,sample,subsignal,1:lengths(action,mean_subsignals(action,subsignal))),[3 4 1 2]);
%     subsignal=36;
%     t2=1:lengths(action,mean_subsignals(action,subsignal));
%     y2=permute(actions_warped(action,sample,subsignal,1:lengths(action,mean_subsignals(action,subsignal))),[3 4 1 2]);
%     subsignal=54;
%     t3=1:lengths(action,mean_subsignals(action,subsignal));
%     y3=permute(actions_warped(action,sample,subsignal,1:lengths(action,mean_subsignals(action,subsignal))),[3 4 1 2]);
%     plot(t1,y1,'marker',marker,'markersize',marker_size,'color',wave_color1/256);
%     plot(t2,y2,'marker',marker,'markersize',marker_size,'color',wave_color2/256);
%     plot(t3,y3,'marker',marker,'markersize',marker_size,'color',wave_color3/256);
%     set(gca,'XTick',[0 20 40 60 80 100]);     set(gca,'YTick',[-60 -40 -20 0 20 40 60 80 100]);     xlim([0 105]);     ylim([-60 100]);     
%     title('"Sample N^{Sit}, Warped with the Mean-Sample"');     legend('Head - Height','Right Hand - Depth','Right Knee - Depth','Location','east');     xlabel('Time (frames)');     ylabel('Value (cm)');
%     set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%     print(h,'warped3','-dpdf','-r0');
    
    % Template
%     h=figure;
%     hold on;
%     colors=hsv(size(actions,3));
%     for subsignal=1:size(actions,3)
%         t=1:lengths(action,mean_subsignals(action,subsignal));
%         y=permute(temp_mean(action,subsignal,1:lengths(action,mean_subsignals(action,subsignal))),[3 4 1 2]);
%         plot(t,y,'marker',marker,'markersize',marker_size,'color',colors(subsignal,:));
%     end
%     set(gca,'XTick',[0 50 100 150 200 250]);     set(gca,'YTick',[-80 -60 -40 -20 0 20 40 60 80]);     xlim([0 260]);     ylim([-100 90]);     
%     title('"Template Of Action C"');     xlabel('Time (frames)');     ylabel('Value (cm)');
%     set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%     print(h,'template','-dpdf','-r0');
    
%     h=figure;
%     hold on;
%     subsignal=11;
%     t1=1:lengths(action,mean_subsignals(action,subsignal));
%     y1=permute(temp_mean(action,subsignal,1:lengths(action,mean_subsignals(action,subsignal))),[3 4 1 2]);
%     subsignal=36;
%     t2=1:lengths(action,mean_subsignals(action,subsignal));
%     y2=permute(temp_mean(action,subsignal,1:lengths(action,mean_subsignals(action,subsignal))),[3 4 1 2]);
%     subsignal=54;
%     t3=1:lengths(action,mean_subsignals(action,subsignal));
%     y3=permute(temp_mean(action,subsignal,1:lengths(action,mean_subsignals(action,subsignal))),[3 4 1 2]);
%     plot(t1,y1,'marker',marker,'markersize',marker_size,'color',wave_color1/256);
%     plot(t2,y2,'marker',marker,'markersize',marker_size,'color',wave_color2/256);
%     plot(t3,y3,'marker',marker,'markersize',marker_size,'color',wave_color3/256);
%     set(gca,'XTick',[0 20 40 60 80 100]);     set(gca,'YTick',[-60 -40 -20 0 20 40 60 80 100]);     xlim([0 105]);     ylim([-60 100]);     
%     title('"Template of Action Sit"');     legend('Head - Height','Right Hand - Depth','Right Knee - Depth','Location','east');     xlabel('Time (frames)');     ylabel('Value (cm)');
%     set(gca,'ygrid','on');     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%     print(h,'template','-dpdf','-r0');
%     
%     error('fake');
    
    % Samples
%     y_offset=7;
%     z_offset_within=1;
%     marker='o';
%     wave_color1=[208,32,144];
%     wave_color2=[255,148,25];
%     wave_color3=[188,238,104];
%     points_color=[84,84,84];
%     marker_size=3;
%     freq_offset=2.5;
%     freq_max=10;
%     h=figure;
%     axis([-0.5 1.5 -1 8 -3 18])
%     view(107,5);
%     pbaspect([1 1 1]);
%     hold on;
% 
%     i=0;
%     A=1;
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t1=[0:0.001:1];
%     y1=-A*sin(f*t1+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t2=[0:0.001:1];
%     y2=-A*sin(f*t2+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t3=[0:0.001:1];
%     y3=-A*sin(f*t3+phi);
% 
%     cube_plot([-0.25,0,-2+i*y_offset],1.5,5,4);
%     plot3(t1,1*z_offset_within*ones(size(t1)),y1+i*y_offset,'color',wave_color1/256,'marker',marker,'markersize',marker_size);
%     plot3(t2,2*z_offset_within*ones(size(t2)),y2+i*y_offset,'color',wave_color2/256,'marker',marker,'markersize',marker_size);
%     plot3(t3,4*z_offset_within*ones(size(t3)),y3+i*y_offset,'color',wave_color3/256,'marker',marker,'markersize',marker_size);
%     plot3([0.5],2.8*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],3*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],3.2*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
% 
%     i=0.6;
%     plot3([0.5],2*z_offset_within,(i-0.1)*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],2*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],2*z_offset_within,(i+0.1)*y_offset,'color',points_color/256,'marker','.','markersize',10);
% 
%     i=1.2;
%     A=1;
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t1=[0:0.001:1];
%     y1=-A*sin(f*t1+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t2=[0:0.001:1];
%     y2=-A*sin(f*t2+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t3=[0:0.001:1];
%     y3=-A*sin(f*t3+phi);
% 
%     cube_plot([-0.25,0,-2+i*y_offset],1.5,5,4);
%     plot3(t1,1*z_offset_within*ones(size(t1)),y1+i*y_offset,'color',wave_color1/256,'marker',marker,'markersize',marker_size);
%     plot3(t2,2*z_offset_within*ones(size(t2)),y2+i*y_offset,'color',wave_color2/256,'marker',marker,'markersize',marker_size);
%     plot3(t3,4*z_offset_within*ones(size(t3)),y3+i*y_offset,'color',wave_color3/256,'marker',marker,'markersize',marker_size);
%     plot3([0.5],2.8*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],3*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],3.2*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
% 
%     i=2.2;
%     A=1;
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t1=[0:0.001:1];
%     y1=-A*sin(f*t1+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t2=[0:0.001:1];
%     y2=-A*sin(f*t2+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t3=[0:0.001:1];
%     y3=-A*sin(f*t3+phi);
% 
%     cube_plot([-0.25,0,-2+i*y_offset],1.5,5,4);
%     plot3(t1,1*z_offset_within*ones(size(t1)),y1+i*y_offset,'color',wave_color1/256,'marker',marker,'markersize',marker_size);
%     plot3(t2,2*z_offset_within*ones(size(t2)),y2+i*y_offset,'color',wave_color2/256,'marker',marker,'markersize',marker_size);
%     plot3(t3,4*z_offset_within*ones(size(t3)),y3+i*y_offset,'color',wave_color3/256,'marker',marker,'markersize',marker_size);
%     plot3([0.5],2.8*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],3*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],3.2*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
% 
%     % Mean sample
%     z_offset_between=10;
%     i=1.0;
% 
%     A=1;
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t1=[0:0.001:1];
%     y1=-A*sin(f*t1+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t2=[0:0.001:1];
%     y2=-A*sin(f*t2+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t3=[0:0.001:1];
%     y3=-A*sin(f*t3+phi);
% 
%     cube_plot([-0.25,z_offset_between,-2+i*y_offset],1.5,5,4);
%     plot3(t1,z_offset_between+1*z_offset_within*ones(size(t1)),y1+i*y_offset,'color',wave_color1/256,'marker',marker,'markersize',marker_size);
%     plot3(t2,z_offset_between+2*z_offset_within*ones(size(t2)),y2+i*y_offset,'color',wave_color2/256,'marker',marker,'markersize',marker_size);
%     plot3(t3,z_offset_between+4*z_offset_within*ones(size(t3)),y3+i*y_offset,'color',wave_color3/256,'marker',marker,'markersize',marker_size);
%     plot3([0.5],z_offset_between+2.8*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],z_offset_between+3*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],z_offset_between+3.2*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
% 
%     % Warped
%     z_offset_between=20;
%     y_offset=7;
%     z_offset_within=1;
% 
%     i=0;
%     A=1;
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t1=[0:0.001:1];
%     y1=-A*sin(f*t1+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t2=[0:0.001:1];
%     y2=-A*sin(f*t2+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t3=[0:0.001:1];
%     y3=-A*sin(f*t3+phi);
% 
%     cube_plot([-0.25,z_offset_between,-2+i*y_offset],1.5,5,4);
%     plot3(t1,z_offset_between+1*z_offset_within*ones(size(t1)),y1+i*y_offset,'color',wave_color1/256,'marker',marker,'markersize',marker_size);
%     plot3(t2,z_offset_between+2*z_offset_within*ones(size(t2)),y2+i*y_offset,'color',wave_color2/256,'marker',marker,'markersize',marker_size);
%     plot3(t3,z_offset_between+4*z_offset_within*ones(size(t3)),y3+i*y_offset,'color',wave_color3/256,'marker',marker,'markersize',marker_size);
%     plot3([0.5],z_offset_between+2.8*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],z_offset_between+3*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],z_offset_between+3.2*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
% 
%     i=0.6;
%     plot3([0.5],z_offset_between+2*z_offset_within,(i-0.1)*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],z_offset_between+2*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],z_offset_between+2*z_offset_within,(i+0.1)*y_offset,'color',points_color/256,'marker','.','markersize',10);
% 
%     i=1.2;
%     A=1;
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t1=[0:0.001:1];
%     y1=-A*sin(f*t1+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t2=[0:0.001:1];
%     y2=-A*sin(f*t2+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t3=[0:0.001:1];
%     y3=-A*sin(f*t3+phi);
% 
%     cube_plot([-0.25,z_offset_between,-2+i*y_offset],1.5,5,4);
%     plot3(t1,z_offset_between+1*z_offset_within*ones(size(t1)),y1+i*y_offset,'color',wave_color1/256,'marker',marker,'markersize',marker_size);
%     plot3(t2,z_offset_between+2*z_offset_within*ones(size(t2)),y2+i*y_offset,'color',wave_color2/256,'marker',marker,'markersize',marker_size);
%     plot3(t3,z_offset_between+4*z_offset_within*ones(size(t3)),y3+i*y_offset,'color',wave_color3/256,'marker',marker,'markersize',marker_size);
%     plot3([0.5],z_offset_between+2.8*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],z_offset_between+3*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],z_offset_between+3.2*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
% 
%     i=2.2;
%     A=1;
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t1=[0:0.001:1];
%     y1=-A*sin(f*t1+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t2=[0:0.001:1];
%     y2=-A*sin(f*t2+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t3=[0:0.001:1];
%     y3=-A*sin(f*t3+phi);
% 
%     cube_plot([-0.25,z_offset_between,-2+i*y_offset],1.5,5,4);
%     plot3(t1,z_offset_between+1*z_offset_within*ones(size(t1)),y1+i*y_offset,'color',wave_color1/256,'marker',marker,'markersize',marker_size);
%     plot3(t2,z_offset_between+2*z_offset_within*ones(size(t2)),y2+i*y_offset,'color',wave_color2/256,'marker',marker,'markersize',marker_size);
%     plot3(t3,z_offset_between+4*z_offset_within*ones(size(t3)),y3+i*y_offset,'color',wave_color3/256,'marker',marker,'markersize',marker_size);
%     plot3([0.5],z_offset_between+2.8*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],z_offset_between+3*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],z_offset_between+3.2*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
% 
%     % Template
%     z_offset_between=30;
%     i=1.0;
% 
%     A=1;
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t1=[0:0.001:1];
%     y1=-A*sin(f*t1+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t2=[0:0.001:1];
%     y2=-A*sin(f*t2+phi);
%     rng('shuffle');
%     f=freq_offset+rand*freq_max;
%     rng('shuffle');
%     phi=rand*2*pi;
%     t3=[0:0.001:1];
%     y3=-A*sin(f*t3+phi);
% 
%     cube_plot([-0.25,z_offset_between,-2+i*y_offset],1.5,5,4);
%     plot3(t1,z_offset_between+1*z_offset_within*ones(size(t1)),y1+i*y_offset,'color',wave_color1/256,'marker',marker,'markersize',marker_size);
%     plot3(t2,z_offset_between+2*z_offset_within*ones(size(t2)),y2+i*y_offset,'color',wave_color2/256,'marker',marker,'markersize',marker_size);
%     plot3(t3,z_offset_between+4*z_offset_within*ones(size(t3)),y3+i*y_offset,'color',wave_color3/256,'marker',marker,'markersize',marker_size);
%     plot3([0.5],z_offset_between+2.8*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],z_offset_between+3*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);
%     plot3([0.5],z_offset_between+3.2*z_offset_within,i*y_offset,'color',points_color/256,'marker','.','markersize',10);

end
