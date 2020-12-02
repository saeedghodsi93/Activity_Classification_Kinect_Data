function object_data_3d = read_object_data_in_3d()

    scale_factor = 100;
    
    cd('dataset')
    temp = load('object_data_3d');
    object_data_3d = temp.object_data_3d;
    cd('..')
    
    object_data_3d = object_data_3d .* scale_factor;
    
end