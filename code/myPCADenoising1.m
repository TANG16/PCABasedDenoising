function [out] = myPCADenoising1(inp,sigma)

patchSize = 7;
[P,~,N] = createPatchMatrices(inp,patchSize);
%% Construct the eigenspace and compute eigencoefficients

[V,~] = eig(P*P');  % construct the eigenspace for the patches
alpha = V'*P;   % compute the eigencoefficients
%% Compute estimate of average squared
patchVectorSize = patchSize^2;
alpha_avg_sq = zeros(patchVectorSize);
for i=1:patchVectorSize
    alpha_avg_sq(i) = sumsqr(alpha(i,:))/N - sigma^2;
end
alpha_avg_sq=max(alpha_avg_sq,0);

%% Wiener filter-like update
alpha_denoised = zeros(size(alpha));
for j=1:patchVectorSize
    if(alpha_avg_sq(j)==0)
        alpha_denoised(j,:) = 0;
    else
        alpha_denoised(j,:) = alpha(j,:)/(1+sigma^2/alpha_avg_sq(j));
    end
end

P_denoised = V*alpha_denoised;

out = imageFromPatches(P_denoised,size(inp,1),size(inp,2));
