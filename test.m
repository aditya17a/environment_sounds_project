function prob_output = test(address,file_list,num_deltas)
% file_list is the list of all files inside the folder specified in the
% address.
% prob_output Size = N*num_classes

N = length(file_list);
%% Load GMMs
addpath('gmms');
gmm_list = dir('gmms/*.mat');
for i=1:length(gmm_list)
    gmm_name = gmm_list(i).name;
    load(gmm_name);
end

num_gaussians = length(gmm_list);
%% Get likelihoods
for i=1:N
    mfcc_features = get_mfcc_data(address,file_list(i),num_deltas); %Size: timeframes x features_with_deltas(13, 26, 39 etc.)
    for j = 1:num_gaussians
        eval(['gmm = ','gmm_',num2str(j)]);
        [p, nlogn(j)] = posterior(gmm,mfcc_features);
    end
    
    %nlogn = nlogn./sum(nlogn);
    prob_output(i,:) = nlogn;
    
    
end


end