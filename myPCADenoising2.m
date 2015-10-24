function[out] = myPCADenoising2(inp,sigma)

patchSize = 7;
[~,M,~] = createPatchMatrices(inp,patchSize);

