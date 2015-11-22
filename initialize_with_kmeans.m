function S = initialize_with_kmeans(X,K)
[N,D] = size(X);
S.mu = zeros(K,D);
S.Sigma = zeros(D,D,K);
S.PComponents = zeros(1,K);

idx = kmeans(X,K,'Replicates',4,'MaxIter',200);

for i=1:K
    X_k = X(idx==i,:);
    S.mu(i,:) = mean(X_k);
    S.Sigma(:,:,i) = cov(X_k);
    S.PComponents(1,i) = size(X_k,1)/N;
end

display('Exiting K-means...')
end