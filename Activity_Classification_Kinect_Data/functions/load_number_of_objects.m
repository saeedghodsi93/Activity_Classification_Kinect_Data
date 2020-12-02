function numberOfObjects = load_number_of_objects()
    
    cd('dataset')
    temp = load('numberOfObjects');
    temp1 = temp.numberOfObjects;
    numberOfObjects = cell(size (temp1,1), size (temp1,2),size (temp1,3));
    for i = 1 : size(temp1,1)
        for j = 1 :size(temp1,2)
            for k = 1 : size(temp1,3)
                    numberOfObjects{i,j,k} = temp1{i,j,k};
            end
        end
    end
    cd('..')
    
end