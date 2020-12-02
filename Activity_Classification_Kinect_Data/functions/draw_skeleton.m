function [ ] = draw_skeleton( skeleton,number_of_samples,action_length,FolderIdx,TestIdx,ActionIdx,joint_pair,frame_rate )

    h=figure;
%     grid on;
%     hold on;
%     view(3);
%     title('"Trajectories of the Joints"');%     xlabel('Time (frames)');     ylabel('Value (cm)');
    axis(gca,'off');
%     set(h,'Visible','off');
    marker='.';
    marker_size=5;
    line_width=5;
    joint_color=[138	43	226];
    line_color=[39	64	139];
    head_color=[138	43	226];
    right_hand_color=[255	215	0];
    right_knee_color=[127	255	0];
    arrow_color=[69	139	0];
    arrow_color_2=[255	127	0];
    
    for folder_idx=FolderIdx
        for test_idx=TestIdx
            for action_idx=ActionIdx
                if number_of_samples(folder_idx,action_idx)>=test_idx
                    
                    fprintf(1,'folder%d test%d action%d\n',folder_idx,test_idx,action_idx);
                    
                    for frame_idx=1:action_length(folder_idx,test_idx,action_idx)
                        
                        S=permute(skeleton(folder_idx,test_idx,action_idx,frame_idx,:,:),[5 6 1 2 3 4]);

                        % mirror the skeleton
%                         S=zeros(size(skeleton,5),size(skeleton,6));                        
%                         plan_norm = skeleton(folder_idx,test_idx,action_idx,frame_idx,4,:)-skeleton(folder_idx,test_idx,action_idx,frame_idx,6,:);
%                         plan_norm = permute(plan_norm,[6 1 2 3 4 5]);
%                         plan_norm(2) = 0;
%                         plan_norm = plan_norm ./ norm(plan_norm);
%                         for joint_idx = 1:size(skeleton,5)
%                             diff = skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_idx,:) - skeleton(folder_idx,test_idx,action_idx,frame_idx,3,:);
%                             diff = permute(diff,[6 1 2 3 4 5]);
%                             project = 2*dot(diff,plan_norm);
%                             mirror = permute(skeleton(folder_idx,test_idx,action_idx,frame_idx,joint_idx,:),[6 1 2 3 4 5]) - project .* plan_norm;
%                             switch(joint_idx)
%                                 case 1 % spine
%                                     S(1,:) = mirror;
%                                 case 2 % neck
%                                     S(2,:) = mirror;
%                                 case 3 % torso
%                                     S(3,:) = mirror;
%                                 case 4 % left shoulder
%                                     S(6,:) = mirror;
%                                 case 5 % left elbow
%                                     S(7,:) = mirror;
%                                 case 6 % right shoulder
%                                     S(4,:) = mirror;
%                                 case 7 % right elbow
%                                     S(5,:) = mirror;
%                                 case 8 % left hip
%                                     S(10,:) = mirror;
%                                 case 9 % left knee
%                                     S(11,:) = mirror;
%                                 case 10 % right hip
%                                     S(8,:) = mirror;
%                                 case 11 % right knee
%                                     S(9,:) = mirror;
%                                 case 12 % left hand
%                                     S(13,:) = mirror;
%                                 case 13 % right hand
%                                     S(12,:) = mirror;
%                                 case 14 % left foot
%                                     S(15,:) = mirror;
%                                 case 15 % right foot
%                                     S(14,:) = mirror;
%                             end
%                         end
                        
                        % draw the skeleton
                        J=S;
                        J([8,12,16,20],:)=[];
%                         plot3(J(1,1),J(1,3),J(1,2),'marker',marker,'markersize',marker_size,'color',head_color/255);
%                         plot3(J(13,1),J(13,3),J(13,2),'marker',marker,'markersize',marker_size,'color',right_hand_color/255);
%                         plot3(J(11,1),J(11,3),J(11,2),'marker',marker,'markersize',marker_size,'color',right_knee_color/255);
                        plot3(J(:,1),J(:,3),J(:,2),'r.','markersize',5);
%                         legend('Head','Right Hand','Right Knee','Location','east','Orientation','vertical');
                        for j=1:size(joint_pair,2)
                            c1=joint_pair(1,j);
                            c2=joint_pair(2,j);
                            line([S(c1,1) S(c2,1)], [S(c1,3) S(c2,3)], [S(c1,2) S(c2,2)],'color',line_color/255,'marker',marker,'linewidth',line_width);
                        end
    
                        % draw an object in the hand
                        body_x_direction = J(5,:)-J(8,:);
                        body_ang = atan2(body_x_direction(1,3),body_x_direction(1,1));
                        object_pos = [S(8,1) S(8,3) S(8,2)];
                        draw_cube(object_pos,5,-5,5,body_ang);
                        
                        % coordinate axis
                        arrow3([0 0 0],[50 0 0],'color',arrow_color/255,'stemWidth',1,'tipWidth',3,'facealpha',0.5);
                        arrow3([0 0 0],[0 -50 0],'color',arrow_color/255,'stemWidth',1,'tipWidth',3,'facealpha',0.5);
                        arrow3([0 0 0],[0 0 50],'color',arrow_color/255,'stemWidth',1,'tipWidth',3,'facealpha',0.5);
                        
                        % shoulder to shoulder axis
                        arrow3(J(5,[1,3,2]),J(8,[1,3,2]),'color',arrow_color_2/255,'stemWidth',0.5,'tipWidth',1.5,'facealpha',0.5);
                        arrow3(J(8,[1,3,2]),J(5,[1,3,2]),'color',arrow_color_2/255,'stemWidth',0.5,'tipWidth',1.5,'facealpha',0.5);

                        xlim = [-50 100];
                        ylim = [-75 75];
                        zlim = [-120 120];
                        set(gca, 'xlim',xlim, 'ylim',ylim, 'zlim',zlim);
                        set(gca,'DataAspectRatio',[1 1 1]);
%                         axis([xlim ylim zlim]);
                        %rotate(h,[0 45], -180);
                        view(-15,30);
                        
                        % save as pdf
                        if mod(frame_idx,5)==0
                            set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
                            print(h,strcat(pwd,'\debug\figures\','figure',num2str(frame_idx)),'-dpdf','-r300');
%                             savefig(h,strcat(pwd,'\debug\figures\','figure',num2str(frame_idx)));
                        end
                        
                        pause(1/frame_rate);

                    end
                    pause(1);
                    
                end
            end
        end
    end
    
end

% fprintf(1,'folder%d test%d action%d\n',folder_idx,test_idx,action_idx);
%                     
% frame=400;
% S=permute(skeleton(folder_idx,test_idx,action_idx,1:frame,:,:),[4 5 6 1 2 3]);
% J=S;
% %                         J([8,12,16,20],:)=[];
% plot3(J(:,1,1),J(:,1,3),J(:,1,2),'marker',marker,'markersize',marker_size,'color',head_color/255);
% plot3(J(:,13,1),J(:,13,3),J(:,13,2),'marker',marker,'markersize',marker_size,'color',right_hand_color/255);
% plot3(J(:,11,1),J(:,11,3),J(:,11,2),'marker',marker,'markersize',marker_size,'color',right_knee_color/255);
% legend('Head','Right Hand','Right Knee','Location','east','Orientation','vertical');
% %                         for j=1:size(joint_pair,2)
% %                             c1=joint_pair(1,j);
% %                             c2=joint_pair(2,j);
% %                             line([S(c1,1) S(c2,1)], [S(c1,3) S(c2,3)], [S(c1,2) S(c2,2)], 'color',line_color/255,'marker',line_marker,'linewidth',line_width);
% %                         end
% 
% xlim = [-75 75];
% ylim = [-75 75];
% zlim = [-80 100];
% set(gca, 'xlim',xlim, 'ylim',ylim, 'zlim',zlim);
% set(gca,'DataAspectRatio',[1 1 1]);
% %                         axis([xlim ylim zlim]);
% %rotate(h,[0 45], -180);
% 
%     set(h,'Units','Inches');     pos = get(h,'Position');     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%     print(h,strcat('C:\MATLAB\Code\action_template\debug\figures\','figure'),'-dpdf','-r600');
% 
% pause(1);