function [output_mat] = appendDeltas(input_mat, numDeltas)
% input_mat: The input matrix of MFCCs of size 13 X K, where K is the
% length of the sequence.
% numDeltas = number of deltas terms to be appended (1st derivatives, 2nd
% derivatives etc.).
% output_mat = matrix with deltas appended as
% [..double_deltas;deltas;input].


K = size(input_mat,2);
output_mat = input_mat;

for i = 1:numDeltas

    temp = [];
    temp(:,1) = input_mat(:, 1);
    temp(:,K+2) = input_mat(:, K);
    temp(:,2:K+1) = input_mat;

    forward_temp(:,1:K) = temp(:,3:K+2); 
    backward_temp(:,1:K) = temp(:,1:K); 

    deltas = 0.5*(forward_temp - backward_temp);

    output_mat = [deltas;output_mat];
    input_mat = deltas;
end