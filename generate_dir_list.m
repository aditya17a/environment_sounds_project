function dir_list = generate_dir_list(directory)
% This funtion creates a list of all classes in the ESC database and
% returns it as a cell
addpath(genpath(directory));
dir_all_contents = dir(directory);
dir_indices = find(vertcat(dir_all_contents.isdir));
for i = 1:length(dir_indices)
    dir_list{i} = dir_all_contents(dir_indices(i)).name;
end
dir_list = dir_list(cellfun(@(x) x(1)~='.', dir_list));
end
