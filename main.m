addpath(genpath('mfcc'));
directory = 'ESC-50';
dir_list = generate_dir_list(directory);
num_classes = length(dir_list);
%% Flags
mfcc_flag = true
train_flag = true
test_flag = true
%% Initialize parameters
num_deltas = 2;
number_of_gaussians = 8;

%% Generate MFCC features
if mfcc_flag    
    mfcc_features = cell(num_classes,1);    
    for i=1:num_classes
        
        file_list = dir(strcat(directory,'/',dir_list{i},'/*.ogg'));
        
        for j=1:length(file_list)
        file_names{j} = file_list(j).name;
        end
        
        address = strcat(directory, '/', dir_list{i});
        mfcc_features{i,1} = get_mfcc_data(address, file_names, num_deltas);
    end
end

%% Fit GMMs
if train_flag
    for class=1:num_classes
        class
    % Use k-means to initialize 
     X = mfcc_features{class,1};
     S = initialize_with_kmeans(X,number_of_gaussians);

    % Create GMMs
    display('fitting...')
    obj = fitgmdist(X,number_of_gaussians,'Start',S,'Options',statset('Display','final','MaxIter',200,'TolFun',1e-6));
    eval(['gmm_' num2str(class) '= obj']);
    save(strcat('gmms_50/gmm_',num2str(class)),strcat('gmm_',num2str(class)));
    end
end

%% Test 
count = 0;
num_samples = 0;
if test_flag
    for i=1:length(dir_list)
        file_list = dir(strcat(directory,'/',dir_list{i},'/*.ogg'));
        for j=1:length(file_list)
            file_names{j} = file_list(j).name;
        end
        num_samples = num_samples + numel(file_names);
    address = strcat(directory, '/', dir_list{i});
    prob_output{i,1} = test(address,file_names,num_deltas); %Size = N*num_classes
    [~, I]=min(prob_output{i,1},[],2);
    c = numel(find(I == i));
    count = count + c;
    end
    accuracy = count/num_samples
end
