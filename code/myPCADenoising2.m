function[out] = myPCADenoising2(inp,sigma)

patchSize = 7;
[~,M,~] = createPatchMatrices(inp,patchSize);

K=200;
N=31;
P_denoised = closestPatchSearch(M,K,N,sigma);

out = imageFromPatches(P_denoised,size(inp,1),size(inp,2));

