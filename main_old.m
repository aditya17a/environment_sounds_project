clc; close all;
read_data_flag = true;
mfcc_flag = true;
%% Read in data
if read_data_flag

    labels = csvread('labels.csv');

    whale_sound_indices = find(labels == 1); 
    non_whale_sound_indices = find(labels == 0);
    whale_sound_fileList = cell(size(whale_sound_indices));
    non_whale_sound_fileList = cell(size(non_whale_sound_indices));
    fileList = cell(size(labels));
    
 % Get list of all files  
    for i=1:length(labels)
        fileList{i} = strcat('train',num2str(i),'.aiff');
    end
 % Get list of files of whale sounds 
    for i = 1:length(whale_sound_indices)
        index = whale_sound_indices(i);
        whale_sound_fileList{i} = strcat('train',num2str(index),'.aiff');      
    end
 % Get list of files of non-whale sounds   
    for i = 1:length(non_whale_sound_indices)
        index = non_whale_sound_indices(i);
        non_whale_sound_fileList{i} = strcat('train',num2str(index),'.aiff');      
    end
end

%% Get MFCC features with deltas

if mfcc_flag
    numDeltas = 1;
    mfcc_features_whale = get_mfcc_data(whale_sound_fileList,numDeltas);
    mfcc_features_non_whale = get_mfcc_data(non_whale_sound_fileList,numDeltas);
end
%% Gaussian Mixture Model
k = 4;
%obj_whale_mini = fitgmdist(mfcc_features_whale',k,'Start','randSample');

%% Clear unwanted variables
clear i index whale_sound_indices;