function[out] = myPCADenoising1(inp,sigma)

patchSize = 7;
[P,~,N] = createPatchMatrices(inp,patchSize);
%% Construct the eigenspace and compute eigencoefficients

[V,~] = eig(P*P');  % construct the eigenspace for the patches
alpha = V'*P;   % compute the eigencoefficients

%% Compute estimate of average squared 
alpha_avg_sq = matrix(N);
for i=1:N
    avg = sumsqr(alpha(:,i))/N - sigma^2;
    if(avg>0)
        alpha_avg_sq(i) = avg;
    else
        alpha_avg_sq(i) = 0;
    end
end

%% Wiener filter-like update
alpha_denoised = matrix(size(alpha));
for j=1:N
    if(alpha_avg_sq(j)==0)
        alpha_denoised(:,j) = 0;
    else
        alpha_denoised(:,j) = alpha(:,j)/(1+sigma^2/alpha_avg_sq(j));
    end
end

P_denoised = V*alpha_denoised;

out = reassemble(P_denoised);
