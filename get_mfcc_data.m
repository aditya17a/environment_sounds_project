function [mfcc_concatenated] = get_mfcc_data(address, fileList, numDeltas)
% Size of mfcc_concatenated = (N*timeframes)xfeatures_with_deltas(13, 26, 39 etc.)
% This function returns the concatenated mfcc features with the option of 
% appending deltas.
% fileList = Cell of filenames to be read in; numDeltas = number of deltas
% to be appended

    addpath('data');
    addpath('mfcc'); 
    
    Tw = 25;                % analysis frame duration (ms)
    Ts = 10;                % analysis frame shift (ms)
    alpha = 0.97;           % preemphasis coefficient
    M = 20;                 % number of filterbank channels 
    C = 12;                 % number of cepstral coefficients
    L = 22;                 % cepstral sine lifter parameter
    LF = 200;               % lower frequency limit (Hz)
    HF = 1000;              % upper frequency limit (Hz)
 
    mfcc_concatenated=[];
    for i = 1:length(fileList)
        file_path = strcat(address,'/',fileList{i});
        %i
        [s,fs] = audioread(file_path);
        s = mean(s,2);
        [ MFCCs, ~, ~ ] = ...
                    mfcc( s, fs, Tw, Ts, alpha, @hamming, [LF HF], M, C+1, L );
        mfcc_concatenated = [mfcc_concatenated MFCCs];
    end

    if nargin > 1
        mfcc_concatenated = appendDeltas(mfcc_concatenated, numDeltas);
    end

    mfcc_concatenated = mfcc_concatenated';

end
