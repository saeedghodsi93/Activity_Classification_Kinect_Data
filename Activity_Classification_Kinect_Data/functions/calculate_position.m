function [position] = calculate_position(skeleton)
fprintf('Calculating Positions\n');
position = permute(skeleton,[6 5 4 3 2 1]);
position = reshape(position,size(skeleton,6)*size(skeleton,5),size(skeleton,4),size(skeleton,3),size(skeleton,2),size(skeleton,1));
position = permute (position ,[5 4 3 2 1]);
end