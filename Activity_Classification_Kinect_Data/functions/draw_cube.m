function draw_cube(origin,X,Y,Z,ang)

    % define the vertexes of the unit cubic
    ver = [1 1 0;0 1 0;0 1 1;1 1 1;0 0 1;1 0 1;1 0 0;0 0 0];
    
    % define the faces of the unit cubic
    fac = [1 2 3 4;4 3 5 6;6 7 8 5;1 2 8 7;6 7 1 4;2 3 5 8];
    col = [192	192	192;244 244 244;244 244 244;244 244 244;244 244 244;244 244 244]/255;

    % define the cube
    cube = [ver(:,1)*X+origin(1),ver(:,2)*Y+origin(2),ver(:,3)*Z+origin(3)];
    
    % rotate the cube
    cen = mean(cube,1);
%     rotation_matrix = [cos(ang),0,-sin(ang);0,1,0;sin(ang),0,cos(ang)];
    rotation_matrix = [cos(ang),sin(ang),0;-sin(ang),cos(ang),0;0,0,1];
    rot_cube = zeros(size(cube));
    for ver_idx=1:size(cube,1)
        r = cube(ver_idx,:) - cen;
        rot_cube(ver_idx,:) = r*rotation_matrix + cen;
    end
    
    % plot the cube
    patch('Faces',fac,'Vertices',rot_cube,'FaceColor','flat','FaceVertexCData',col,'FaceAlpha',1,'Marker','.','EdgeColor',[176	23	31]/255,'LineWidth',1);

end

%     % Method 1:
%     % Define the vertexes of the unit cubic
%     ver = [1 1 0;
%         0 1 0;
%         0 1 1;
%         1 1 1;
%         0 0 1;
%         1 0 1;
%         1 0 0;
%         0 0 0];
%     % Define the faces of the unit cubic
%     fac = [1 2 3 4;
%         4 3 5 6;
%         6 7 8 5;
%         1 2 8 7;
%         6 7 1 4;
%         2 3 5 8];
%     col = [192	192	192;
%         244 244 244;
%         244 244 244%
%         244 244 244;%
%         244 244 244;
%         244 244 244]/255;%
% 
%     cube = [ver(:,1)*X+origin(1),ver(:,2)*Y+origin(2),ver(:,3)*Z+origin(3)];
%     patch('Faces',fac,'Vertices',cube,'FaceColor','flat','FaceVertexCData',col,'FaceAlpha',1,'Marker','.','EdgeColor',[176	23	31]/255,'LineWidth',1);

%     % Method 2:
%     axis equal, axis on, hold off, view(20,10)
% 
%     H=[0 1 0 1 0 1 0 1; 0 0 1 1 0 0 1 1; 0 0 0 0 1 1 1 1];
%     S=[1 2 4 3; 1 2 6 5; 1 3 7 5; 3 4 8 7; 2 4 8 6; 5 6 8 7];
%     
%     % Rotation along x axes 
%     Rx = [1 0 0 ; 0 cos(ang) -sin(ang); 0 sin(ang) cos(ang)] ;
%     HR = zeros(size(H)) ;
%     for j = 1:size(H,2)
%         HR(:,j) = Rx*H(:,j) ;
%     end
%     for k=1:size(S,1)
%         fill3(HR(1,S(k,:)),HR(2,S(k,:)),HR(3,S(k,:)),'g','facealpha',0.6)
%         hold on
%     end
%     drawnow
%     hold off